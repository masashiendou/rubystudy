class Player
  def play_turn(warrior)

    if @health.nil?
      @health = 20
    end
    if @empty.nil?
      @empty = warrior.feel.empty?
    end
    if @enemy.nil?
      @enemy = warrior.feel.enemy?
    end

    if @health > warrior.health
      # damage
      if @health < 12
        warrior.walk!(:backward)
      elsif warrior.look[1] == @enemy or warrior.look[2] == @enemy
        warrior.shoot!
      elsif warrior.feel.empty?
        warrior.walk!
      else
        warrior.attack!
      end
    else
      if @health < 15
        if warrior.feel(:backward).empty?
          warrior.walk!(:backward)
        elsif warrior.feel(:backward).captive?
          warrior.rescue!(:backward)
        elsif warrior.feel(:backward).wall?
          warrior.rest!
        elsif warrior.look[1] == @enemy or warrior.look[2] == @enemy
          warrior.shoot!
        else
          warrior.walk!
        end
      elsif warrior.look[3] == @enemy
        warrior.shoot!
      elsif warrior.feel.captive?
        warrior.rescue!
      elsif warrior.feel.empty?
        warrior.walk!
      elsif warrior.feel.wall?
        warrior.pivot!
      else
        warrior.attack!
      end
    end
    @health = warrior.health
  end
end
