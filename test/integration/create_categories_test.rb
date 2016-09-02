require 'test_helper'

class CreateCategoriesTest < ActionDispatch::IntegrationTest
  #模擬新增一個category的過程並檢查是否成功 
  test "get new category form and create category" do
    get new_category_path  #打開(get 動詞) new_category路徑(path)
    assert_template 'categories/new' #正確產生頁面
      #Asserts that the request was rendered with the appropriate template file or partials.
    assert_difference 'Category.count', 1 do #完成新增後，category數目會+1
      post_via_redirect categories_path, category: {name: "sports"}
      #post動詞 post a form, enter a category name: sports
    end
    assert_template 'categories/index' #send user to categoris/index after create a category
    assert_match "sports", response.body #assure category name has been created. find "sports" in the page
  end
  
  test "invalid category submission results in failure" do
    get new_category_path  #打開(get 動詞) new_category路徑(path)
    assert_template 'categories/new' #正確產生頁面
      #Asserts that the request was rendered with the appropriate template file or partials.
    assert_no_difference 'Category.count' do #完成新增後，category數目會+1
      post categories_path, category: {name: " "}# 沒有redirect 只有 post 
      #因為沒有save成功的話還是會在'new'頁面 (見categories_controller.rb #create的else條件)
      #post動詞 post a form, enter a category name: sports
    end
    assert_template 'categories/new' #send user to categoris/index after create a category
    assert_select 'h2.panel-title'
    assert_select 'div.panel-body'
    # 出現以上兩行表示出現 來自view/shared/_errors.heml.erb 的錯誤
 
  end
end