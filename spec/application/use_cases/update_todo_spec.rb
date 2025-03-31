require "rails_helper"

RSpec.describe UpdateTodo do
  let(:repo) { instance_double("TodoRepository") }
  let(:use_case) { described_class.new(todo_repository: repo) }
  let(:user) { double("User", id: 1, admin?: false) }

  let(:todo) { double("Todo", user_id: 1) }
  let(:params) { { title: "Updated" } }

  it "updates if authorized" do
    expect(repo).to receive(:find).with(5).and_return(todo)
    expect(repo).to receive(:update).with(5, params).and_return("updated_todo")

    result = use_case.call(user: user, id: 5, params: params)
    expect(result).to eq("updated_todo")
  end

  it "raises error if unauthorized" do
    allow(todo).to receive(:user_id).and_return(2)
    expect(repo).to receive(:find).with(5).and_return(todo)

    expect {
      use_case.call(user: user, id: 5, params: params)
    }.to raise_error(ActiveRecord::RecordNotFound)
  end
end
