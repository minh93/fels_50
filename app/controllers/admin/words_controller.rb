class Admin::WordsController < Admin::BaseController
  require "csv"
  before_action :verify_admin
  
  def index
  end

  def create
    import params[:file]
  end

  private
  def import file
    begin
      CSV.foreach file.path, headers: true do |f|
        item_hash = f.to_hash
        if csv_file? item_hash
          category = Category.find_or_create_by name: item_hash["category_name"]
          word = Word.find_by content: item_hash["word_content"]
          if word.nil?
            word = Word.create content: item_hash["word_content"], category_id: category.id
            Answer.create content: item_hash["true_answer"], word_id: word.id, is_correct: true
            item_hash["other_answers"].to_s.split("/").each do |ans|
              Answer.create content: ans, word_id: word.id, is_correct: false
            end
          end
        end
      end
      flash[:success] = t "admin.words.index.flash_success"
      redirect_to categories_path
    rescue Exception
      flash[:danger] = t "admin.words.index.flash_danger"
      redirect_to categories_path
    end
  end

  def csv_file? item_hash
    !(item_hash["category_name"].nil? &&
      item_hash["word_content"].nil? &&
      item_hash["true_answer"].nil? &&
      item_hash["other_answers"].nil?)
  end
end
