require('spec_helper')

describe('adding a new store', {:type => :feature}) do
    it('allows a user to click a store to see the brands and details for it') do
      visit('/stores/new')
      # click_button('Add New Store')
      fill_in('name', :with =>'Adrian Cole')
      click_button('Add')
      expect(page).to have_content('Success!')
    end
  end

  describe('viewing all of the stores', {:type => :feature}) do
    it('allows a user to see all of the stores that have been created') do
      store = Store.new({:name => 'Dan Nathan', :id => nil})
      store.save()
      visit('/')
      click_link('Storeists')
      expect(page).to have_content(store.name)
    end
  end

  describe('seeing details for a single store', {:type => :feature}) do
    it('allows a user to click a store to see the brands and details for it') do
      test_store = Store.new({:name => 'Jane Njoki', :id => nil})
      test_store.save()
      test_brand = Brand.new({:name => "Mary Kimani", :store_id => test_store.id()})
      test_brand.save()
      visit('/stores')
      click_link(test_store.name())
      expect(page).to have_content(test_brand.name())
    end
  end

  describe('adding brands to a store', {:type => :feature}) do
    it('allows a user to add a brand to a store') do
      test_store = Store.new({:name => 'Jane Njoki', :id => nil})
      test_store.save()
      visit("/add")
      fill_in("Brand", {:with => "Kimani Njoki"})
      click_button("Add Brand")
      expect(page).to have_content("Success!")
    end
  end