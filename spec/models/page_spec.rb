require "spec_helper"

describe Page do

  before(:all) do
    @db = Airmodel.bases[:pages]
    stub_airtable_response!(
      "https://api.airtable.com/v0/#{@db[:bases]}/#{@db[:table_name]}?shard=&filterByFormula=AND%28%7Bslug%7D%3D%27home%27%29&limit=1",
      { "records" => [
        {"id": "recXYZ", fields: {"slug" => "home", "Slides" => ["recETC", "recWTF"] } },
        {"id":"recABC", fields: {"slug" => "about", "Slides" => [] } }]
      }
    )
    stub_airtable_response!(
      "https://api.airtable.com/v0/#{@db[:bases]}/Sections?shard=&filterByFormula=OR%28id%3D%27recWTF%27%2Cid%3D%27recETC%27%29",
      { "records" => [] }
    )
  end

  describe "Class Methods" do

    describe "find_by_slug" do
      it "finds a page by url slug" do
        page = Page.find_by_slug "home"
        expect(page.slug).to eq "home"
      end
      it "works when the slug is mixed-case" do
        page = Page.find_by_slug "HoMe"
        expect(page.slug).to eq "home"
      end
    end

    describe "find_by_slug_cached" do
      it "finds the page in cache when possible" do
        page = Page.find_by_slug_cached "HOME"
        expect(App.cache.get(page.cache_key)).not_to eq nil
      end
    end
  end
end
