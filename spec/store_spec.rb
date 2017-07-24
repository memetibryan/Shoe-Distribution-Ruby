require('rspec')
  require('pg')
  require('spec_helper')

  describe(Brand) do
    describe(".all") do
      it("is empty at first") do
        expect(Brand.all()).to(eq([]))
      end
    end

    describe("#save") do
      it("adds a brand to the array of saved brands") do
        test_brand = Brand.new({:name => "learn SQL", :store_id => 1})
        test_brand.save()
        expect(Brand.all()).==([test_brand])
      end
    end

    describe("#name") do
      it("lets you read the name out") do
        test_brand = Brand.new({:name => "learn SQL", :store_id => 1})
        expect(test_brand.name()).==("learn SQL")
      end
    end

    describe("#store_id") do
      it("lets you read the store ID out") do
        test_brand = Brand.new({:name => "learn SQL", :store_id => 1})
        expect(test_brand.store_id()).==(1)
      end
    end

    describe("#==") do
      it("is the same brand if it has the same name and store ID") do
        brand1 = Brand.new({:name => "learn SQL", :store_id => 1})
        brand2 = Brand.new({:name => "learn SQL", :store_id => 1})
        expect(brand1).==(brand2)
      end
    end
  end

  describe(".find") do
      it("returns a store by its ID") do
        test_store = Store.new({:name => "Moringaschool stuff", :id => nil})
        test_store.save()
        test_store2 = Store.new({:name => "Home stuff", :id => nil})
        test_store2.save()
        expect(Store.find(test_store2.id())).to(eq(test_store2))
      end
    end

    describe("#brands") do
      it("returns an array of brands for that store") do
        test_store = Store.new({:name => "Moringaschool stuff", :id => nil})
        test_store.save()
        test_brand = Brand.new({:name => "Learn SQL", :store_id => test_store.id()})
        test_brand.save()
        test_brand2 = Brand.new({:name => "Review Ruby", :store_id => test_store.id()})
        test_brand2.save()
        expect(test_store.brands()).==([test_brand, test_brand2])
      end
    end

    describe("#update") do
      it("lets you update stores in the database") do
        store = Store.new({:name => "Moringa School stuff", :id => nil})
        store.save()
        store.update({:name => "Kempinski"})
        expect(store.name()).==("Kempinski")
      end
    end

    describe("#delete") do
      it("lets you delete a store from the database") do
        store = Store.new({:name => "Vila Rosa", :id => nil})
        store.save()
        store2 = Store.new({:name => "Kempinski", :id => nil})
        store2.save()
        store.delete()
        expect(Store.all()).to(eq([store2]))
      end
      
      it("deletes a store's brands from the database") do
        store = Store.new({:name => "Vila Rosa", :id => nil})
        store.save()
        brand = Brand.new({:name => "Kempinski", :store_id => store.id()})
        brand.save()
        brand2 = Brand.new({:name => "Nakumatt", :store_id => store.id()})
        brand2.save()
        store.delete()
        expect(Brand.all()).==([])
      end
    end

    describe(Store) do
      it("validates presence of name") do
      store = Store.new({:name => ""})
      expect(store.save()).to(eq(false))
      end
    end

    describe(Store) do
    it("ensures the length of name is at most 50 characters") do
      store = Store.new({:name => "a".*(20)})
      expect(store.save()).to(eq(false))
      end
    end

    describe(Store) do
    it("converts the name to lowercase") do
      store = Store.create({:name => "VILA ROSA"})
      expect(store.name()).to(eq("Vila Rosa"))
    end
  end