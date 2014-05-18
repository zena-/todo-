require 'spec_helper'

describe "Creating todo lists" do
	def create_todo_list(options={})
		options[:title] ||= "My todo list"
		options[:description] ||= "This is my todo list"

		visit "/todo_lists"
		click_link "New Todo list"
		expect(page).to have_content("New todo_list")

		fill_in "Title", with: options[:title]
		fill_in "Description", with: options[:description]
		click_button "Create Todo list"
	end
		# that method is a simpler way to do what we have done

	# this is saying set by set what should happen
	it "redirects to the todo list index page on success" do
		create_todo_list
		# visit "/todo_lists"
		# click_link "New Todo list"
		# expect(page).to have_content("New todo_list")

		# fill_in "Title", with: "My todo list"
		# fill_in "Description", with: "This is what I'm doing today."
		# click_button "Create Todo list"
		expect(page).to have_content("My todo list")
	end	

	it "displays an error when the todo list has no title" do
		# this is starting from a new page and saying a error should happend if no title 
		expect(TodoList.count).to eq(0)

		create_todo_list title: ""

		# visit "/todo_lists"
		# click_link "New Todo list"
		# expect(page).to have_content("New todo_list")

		# fill_in "Title", with: ""
		# fill_in "Description", with: "This is what I'm doing today."
		# click_button "Create Todo list"

		expect(page).to have_content("error")
		expect(TodoList.count).to eq(0)

		visit "/todo_lists"
		expect(page).to_not have_content("This is what I'm doing today.")

	end

	it "displays an error when the todo list has a title less than 3 characters" do
		# this is starting from a new page and saying a error should happend if title is too short
		expect(TodoList.count).to eq(0)
		create_todo_list title: "Hi"
		# visit "/todo_lists"
		# click_link "New Todo list"
		# expect(page).to have_content("New todo_list")

		# fill_in "Title", with: "Hi"
		# fill_in "Description", with: "This is what I'm doing today."
		# click_button "Create Todo list"

		expect(page).to have_content("error")
		expect(TodoList.count).to eq(0)

		visit "/todo_lists"
		expect(page).to_not have_content("This is what I'm doing today.")

	end

	it "displays an error when the todo list has no Description" do
		# this is starting from a new page and saying a error should happend when no Description
		expect(TodoList.count).to eq(0)
		create_todo_list title: "Shopping list", description: ""
		# visit "/todo_lists"
		# click_link "New Todo list"
		# expect(page).to have_content("New todo_list")

		# fill_in "Title", with: "Shopping list"
		# fill_in "Description", with: ""
		# click_button "Create Todo list"

		expect(page).to have_content("error")
		expect(TodoList.count).to eq(0)

		visit "/todo_lists"
		expect(page).to_not have_content("Shopping list")

	end

	it "displays an error when the todo list has short Description" do
		expect(TodoList.count).to eq(0)
		create_todo_list title: "Shopping list", description: "food"
		# visit "/todo_lists"
		# click_link "New Todo list"
		# expect(page).to have_content("New todo_list")

		# fill_in "Title", with: "Shopping list"
		# fill_in "Description", with: "food"
		# click_button "Create Todo list"

		expect(page).to have_content("error")
		expect(TodoList.count).to eq(0)

		visit "/todo_lists"
		expect(page).to_not have_content("Shopping list")

	end
end