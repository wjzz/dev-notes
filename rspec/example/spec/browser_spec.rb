URL = "https://manytools.org/http-html-text/browser-language/"

RSpec.describe "browser tests", type: :feature do
    it "visit chrome" do
        Capybara.current_driver = :selenium_chrome

        visit URL

        expect(page).to have_text "Your browser's Accept-Language header:"

        if page.body =~ /<code>Your browser's Accept-Language header:<br ?\/?>(.+)<\/code>/
            puts "<<< Languages: #{$1}"
        end
    end

    it "visit chrome headless" do
        Capybara.current_driver = :selenium_chrome_headless

        visit URL

        expect(page).to have_text "Your browser's Accept-Language header:"

        if page.body =~ /<code>Your browser's Accept-Language header:<br ?\/?>(.+)<\/code>/
            puts "<<< Languages: #{$1}"
        end
    end

    it "visit chrome headless custom" do
        Capybara.current_driver = :custom_headless_chrome

        visit URL

        expect(page).to have_text "Your browser's Accept-Language header:"

        if page.body =~ /<code>Your browser's Accept-Language header:<br ?\/?>(.+)<\/code>/
            puts "<<< Languages: #{$1}"
        end
    end

    fit "visit firefox" do
        Capybara.current_driver = :selenium_jp

        visit URL

        expect(page).to have_text "Your browser's Accept-Language header:"

        if page.body =~ /<code>Your browser's Accept-Language header:<br ?\/?>(.+)<\/code>/
            puts "<<< Languages: #{$1}"
        end
    end
end
