def load_data

  def create_transaction(success_count, total)
    success = (total - success_count) - 1
    trans = create_list(:transaction, total)

    (0..success_count-1).each do |n| 
      trans[n].update!(result: "success")
    end
    (total-success_count..total-1).each do |n| 
      trans[n].update!(result: "failed")
    end
    
    return trans
  end
  
end