ActiveAdmin.register_page "Dashboard" do
  content title: proc { I18n.t("active_admin.dashboard") } do
    # Panel for Pass generate details
    panel "Pass generate details" do 
    pass = Pass.find_by(issue_date: Date.today) 
      table_for [pass] do 
        column "One Day" do |pass|
          Pass.where(issue_date: Date.today).count 
        end

        column "Yesterday" do |pass|
          Pass.where(issue_date: Date.yesterday).count
        end

        column "Last Seven Days" do |pass|
          Pass.where("issue_date",Date.today - 6.days).count
        end
      end
    end
    
    # Panel for Categories
    panel "Categories" do
      table_for Category.all do
        column :id
        column :category_name
        column "One Day" do |category|
          category.passes.where(issue_date: Date.today).count
        end
        column "Yesterday Pass " do |category|
          category.passes.where(issue_date: Date.yesterday).count
        end
        column "Last Seven Days Pass " do |category|
          category.passes.where("issue_date", Date.today - 7.days).count
        end
        column "Total Pass " do |category|
          category.passes.count
        end
      end
    end
  end
end
