require "rails_helper"

RSpec.describe CreateTodo do
  let(:repo) { instance_double("TodoRepository") }
  let(:use_case) { described_class.new(todo_repository: repo) }
  let(:user) { double("User", id: 1) }

  let(:params) do
    {
      title: "Test",
      description: "Description",
      status: "pending",
      due_date: Date.today + 1
    }
  end

  it "creates a todo" do
    created = double("Todo")
    expect(repo).to receive(:create).with(hash_including(user_id: 1)).and_return(created)

    result = use_case.call(user: user, params: params)
    expect(result).to eq(created)
  end

  it "raises error if title is missing" do
    expect {
      use_case.call(user: user, params: params.except(:title))
    }.to raise_error(ArgumentError, "Title is required")
  end
end