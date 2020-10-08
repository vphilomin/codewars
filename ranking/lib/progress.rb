class Progress
  def award(difficulty)
    progress_points = case
                      when difficulty == 0 then 3
                      when difficulty == -1 then 1
                      when difficulty <= -2 then 0
                      else
                        10 * difficulty * difficulty
                      end
  end
end
