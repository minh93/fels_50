 module ActivityLog
  def create_log user_id, target_id, type_of_activity
    Activity.create! user_id: user_id, target_id: target_id,
      type_of_activity: type_of_activity
  end
end
