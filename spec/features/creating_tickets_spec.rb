require "rails_helper"

RSpec.feature "Admins can create new tickets" do
  let(:user) {FactoryGirl.create(:user)}
  let(:project) { FactoryGirl.create(:project, name: "Internet Explorer") }  
  before do
    assign_role!(user, :editor, project)
    login_as(user)

    visit project_path(project)
    click_link "New Ticket"
  end

    scenario "with valid attributes" do
      fill_in "Name", with: "Non-standards compliance"
      fill_in "Description", with: "My pages are ugly!"
      click_button "Create Ticket"

      expect(page).to have_content "Ticket has been created."
      within("#ticket") do
        expect(page).to have_content "Author: #{user.email}"
      end
    end

    scenario "when providing invalid attributes" do
      click_button "Create Ticket"

      expect(page).to have_content "Ticket has not been created."
      expect(page).to have_content "Name can't be blank"
      expect(page).to have_content "Description can't be blank"
    end

  scenario "with an invalid description" do
    fill_in "Name", with: "Non-standars compliance"
    fill_in "Description", with: "It sucks"
    click_button "Create Ticket"

    expect(page).to have_content "Ticket has not been created"
    expect(page).to have_content "Description is too short"
  end

  scenario "with an attachment" do
    fill_in "Name", with: "Add documentation for blink tag"
    fill_in "Description", with: "The blink tag has a speed attribute"
    attach_file "File", "spec/fixtures/speed.txt"
    click_button "Create Ticket"

    expect(page).to have_content "Ticket has been created"

    within("#ticket .attachment") do
      expect(page).to have_content "speed.txt"
    end
  end

  scenario "persisting file uploads across form displays" do
    attach_file "File", "spec/fixtures/speed.txt"
    click_button "Create Ticket"

    fill_in "Name", with: "Add documentation for blink tag"
    fill_in "Description", with: "The blink tag has a speed attribute"
    click_button "Create Ticket"

    within("#ticket .attachment") do
      expect(page).to have_content "speed.txt"
    end
  end

  scenario "with an attachment" do
    fill_in "Name", with: "Add documentation for blink tag"
    fill_in "Description", with: "The blink tag has a speed attribute"
    attach_file "File", "spec/fixtures/speed.txt"
    click_button "Create Ticket"

    expect(page).to have_content "Ticket has been created"

<<<<<<< HEAD
=======
  scenario "with an attachment" do
    fill_in "Name", with: "Add documentation for blink tag"
    fill_in "Description", with: "The blink tag has a speed attribute"
    attach_file "File", "spec/fixtures/speed.txt"
    click_button "Create Ticket"

    expect(page).to have_content "Ticket has been created"

>>>>>>> 978fba9dde4c0b82408803bf1ebc3e0d638e64db
    within("#ticket .attachment") do
      expect(page).to have_content "speed.txt"
    end
  end
<<<<<<< HEAD
=======

>>>>>>> 978fba9dde4c0b82408803bf1ebc3e0d638e64db
end