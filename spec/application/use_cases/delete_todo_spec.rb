require "rails_helper"

RSpec.describe DeleteTodo do
  let(:repo) { instance_double("TodoRepository") }
  let(:use_case) { described_class.new(todo_repository: repo) }
  let(:user) { double("User", id: 1, admin?: false) }

  let(:todo) { double("Todo", user_id: 1) }

  it "deletes if authorized" do
    expect(repo).to receive(:find).with(7).and_return(todo)
    expect(repo).to receive(:delete).with(7)

    use_case.call(user: user, id: 7)
  end

  it "raises error if unauthorized" do
    allow(todo).to receive(:user_id).and_return(999)
    expect(repo).to receive(:find).with(7).and_return(todo)

    expect {
      use_case.call(user: user, id: 7)
    }.to raise_error(ActiveRecord::RecordNotFound)
  end
end
