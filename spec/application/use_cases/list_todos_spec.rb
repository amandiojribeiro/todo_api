require "rails_helper"

RSpec.describe ListTodos do
  let(:repo) { instance_double("TodoRepository") }
  let(:use_case) { described_class.new(todo_repository: repo) }

  let(:admin_user) { double("User", id: 1, admin?: true) }
  let(:regular_user) { double("User", id: 2, admin?: false) }

  it "returns all todos for admin" do
    expect(repo).to receive(:paginated_all).with(filters: {}, pagination: {}).and_return(["todo1"])
    result = use_case.call(user: admin_user, filters: {}, pagination: {})
    expect(result).to eq(["todo1"])
  end

  it "returns user's todos for regular user" do
    expect(repo).to receive(:paginated_all_by_user).with(user_id: 2, filters: {}, pagination: {}).and_return(["todo2"])
    result = use_case.call(user: regular_user, filters: {}, pagination: {})
    expect(result).to eq(["todo2"])
  end

  it "passes filters correctly" do
    filters = { status: "done" }
    expect(repo).to receive(:paginated_all_by_user).with(user_id: 2, filters: filters, pagination: {}).and_return(["todo3"])
    result = use_case.call(user: regular_user, filters: filters, pagination: {})
    expect(result).to eq(["todo3"])
  end
end
