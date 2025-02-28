describe "FactoryBot.lint" do
  it "raises when a factory is invalid" do
    define_model "User", name: :string do
      validates :name, presence: true
    end

    define_model "AlwaysValid"

    FactoryBot.define do
      factory :user do
        factory :admin_user
      end

      factory :always_valid
    end

    error_message = <<~ERROR_MESSAGE.strip
      The following factories are invalid:

      * user - Validation failed: Name can't be blank (ActiveRecord::RecordInvalid)
      * admin_user - Validation failed: Name can't be blank (ActiveRecord::RecordInvalid)
    ERROR_MESSAGE

    expect {
      FactoryBot.lint
    }.to raise_error FactoryBot::InvalidFactoryError, error_message
  end

  it "executes linting in an ActiveRecord::Base transaction" do
    define_model "User", name: :string do
      validates :name, uniqueness: true
    end

    define_model "AlwaysValid"

    FactoryBot.define do
      factory :user do
        factory :admin_user
      end

      factory :always_valid
    end

    expect { FactoryBot.lint }.to_not raise_error
  end

  it "does not raise when all factories are valid" do
    define_model "User", name: :string do
      validates :name, presence: true
    end

    FactoryBot.define do
      factory :user do
        name { "assigned" }
      end
    end

    expect { FactoryBot.lint }.not_to raise_error
  end

  it "allows for selective linting" do
    define_model "InvalidThing", name: :string do
      validates :name, presence: true
    end

    define_model "ValidThing", name: :string

    FactoryBot.define do
      factory :valid_thing
      factory :invalid_thing
    end

    expect {
      only_valid_factories = FactoryBot.factories.reject { |factory|
        factory.name =~ /invalid/
      }

      FactoryBot.lint only_valid_factories
    }.not_to raise_error
  end

  describe "trait validation" do
    context "enabled" do
      it "raises if a trait produces an invalid object" do
        define_model "User", name: :string do
          validates :name, presence: true
        end

        FactoryBot.define do
          factory :user do
            name { "Yep" }
            trait :unnamed do
              name { nil }
            end
          end
        end

        error_message = <<~ERROR_MESSAGE.strip
          The following factories are invalid:

          * user+unnamed - Validation failed: Name can't be blank (ActiveRecord::RecordInvalid)
        ERROR_MESSAGE

        expect {
          FactoryBot.lint traits: true
        }.to raise_error FactoryBot::InvalidFactoryError, error_message
      end

      it "does not raise if a trait produces a valid object" do
        define_model "User", name: :string do
          validates :name, presence: true
        end

        FactoryBot.define do
          factory :user do
            name { "Yep" }
            trait :renamed do
              name { "Yessir" }
            end
          end
        end

        expect {
          FactoryBot.lint traits: true
        }.not_to raise_error
      end
    end

    context "disabled" do
      it "does not raises if a trait produces an invalid object" do
        define_model "User", name: :string do
          validates :name, presence: true
        end

        FactoryBot.define do
          factory :user do
            name { "Yep" }
            trait :unnamed do
              name { nil }
            end
          end
        end

        expect {
          FactoryBot.lint traits: false
          FactoryBot.lint
        }.not_to raise_error
      end
    end
  end

  describe "factory strategy for linting" do
    it "uses the requested strategy" do
      define_class "User" do
        attr_accessor :name

        def save!
          raise "expected :build strategy, #save! shouldn't be invoked"
        end
      end

      FactoryBot.define do
        factory :user do
          name { "Barbara" }
        end
      end

      expect {
        FactoryBot.lint strategy: :build
      }.not_to raise_error
    end

    it "uses the requested strategy during trait validation" do
      define_class "User" do
        attr_accessor :name

        def save!
          raise "expected :build strategy, #save! shouldn't be invoked"
        end
      end

      FactoryBot.define do
        factory :user do
          name { "Barbara" }

          trait :male do
            name { "Bob" }
          end
        end
      end

      expect {
        FactoryBot.lint traits: true, strategy: :build
      }.not_to raise_error
    end
  end

  describe "verbose linting" do
    it "prints the backtrace for each factory error" do
      define_class("InvalidThing") do
        def save!
          raise "invalid"
        end
      end

      FactoryBot.define do
        factory :invalid_thing
      end

      expect {
        FactoryBot.lint(verbose: true)
      }.to raise_error(
        FactoryBot::InvalidFactoryError,
        %r{#{__FILE__}:\d*:in ('InvalidThing#save!'|`save!')}
      )
    end
  end
end
