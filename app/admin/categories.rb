ActiveAdmin.register Category do
  show do   
    panel  "Category Details" do 
      attributes_table_for category do 
        row :id
        row :category_name
      end
    end  
  end
end
