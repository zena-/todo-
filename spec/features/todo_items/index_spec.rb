require 'spec_helper'

describe "Viewing todo items" do
	let!(:todo_list) { TodoList.create(title: "Shopping list", description: "Shopping") }
	it "displays no items when a todo is empty" do
		visit "/todo_lists"
		within "#todo_list_#{todo_list.id}" do
			click_link "List Items"
		end
		expect(page).to have_content("TodoItems#index")
	end
end