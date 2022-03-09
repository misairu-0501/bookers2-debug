class AddEvaluationToBook < ActiveRecord::Migration[6.1]
  def change
    add_column :books, :evaluation, :flot
  end
end
