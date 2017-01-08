#Elizabeth Cepernich
#eceperni@ucsc/edu // 1316976
#CMPS 112 Winter 2016
#Final Project
#3/11/2016

#import all classes to be used
load 'Item.rb'
load 'Inventory.rb'
load 'TrainCar.rb'
load 'Person.rb'
load 'Interaction.rb'

class Fight
  #initialize method - boss has 20HP to start
  def initialize()
    @bosshealth=20
  end

  def getBossHealth()
    return @bosshealth
  end
  def assignBossHealth(num)
    @bosshealth=num
  end

  #player attack
  def attack(inventory)
    bossHealth=@bosshealth
    #create new interaction in case of gun choice
    interaction=Interaction.new
    #check for weapons
    canAttack=false
    if inventory.contains("cattle prod",1) or inventory.contains("loaded gun",1)
      canAttack=true
    end
    #get user input for attack multiplier
    print "How do you want to attack? ("
    if inventory.contains("cattle prod",1)
      print "cattle prod/"
    end
    if inventory.contains("loaded gun",1)
      print "loaded gun/"
    end
    print "punch) "
    attack=gets.chomp
    #carry out attack
    if attack == "cattle prod"
      if inventory.contains("cattle prod",1)
        @bosshealth=@bosshealth-5
        print @bosshealth
        print "\n"
      end
    elsif attack == "loaded gun"
      if inventory.contains("loaded gun",1) == true
        #use shoot interaction to manage inventory when shooting a gun
        #shooting a gun discharges one bullet, and if you run out of bullets, you lose your loaded gun
        inventory=interaction.shoot(inventory)
        @bosshealth=@bosshealth-15
        print @bosshealth
        print "\n"
      end
    elsif attack == "punch"
      @bosshealth=@bosshealth-2
    else
      print "You cannot use that attack."
    end
    #returns inventory because the shoot method alters a player's inventory
    return inventory
  end

  #possibility of instant death
  def attacked()
    #calculate amout of damage done
    damageChance=20-@bosshealth
    if @bosshealth > 3
      #calculate chance of a successful attack
      #less damage done means higher chance of success
      chance=rand(damageChance)
      if chance == 1
        return true
      else
        return false
      end
    else
      return false
    end
  end

  def bossFight(inventory)
    #intro
    print "\n \n \n \n \n \n \n \n "
    print "You make it to the front of the front of the train and burst into the front car. \n"
    print "The conductor looks up at you, startled, before his face twists into a glare. \n"
    print "He shouts 'get back!' and tries to strike out at you, but your job is to derail this train,"
    print "and you're going to do it if it kills you. \n \n "
    print "Warning: every time you attack, there is a chance the train conductor will strike back.\n "
    print "The more health he has, the more likely you are to be attacked. Use your weapons wisely."
    #loops while boss and player are still alive
    while @bosshealth > 0
      inventory.showInventory()
      #carry out attack
      attack(inventory)
      #get attack chance
      attackChance=attacked()
      #if you are successfully attacked
      if attackChance == true
        #death screen
        if @bosshealth > 15
          print "The conductor recovers from a stumble and catches you by the arm. \n"
          print "You try to punch him off, but he grabs hold of the door and yanks it open. \n"
          print "The force of intertia carries you to the edge of the train car and one last solid shove pushes you out onto the tracks! \n"
        elsif @bosshealth > 9
          print "The conductor pauses to catch his breath. You look down at just the wrong time, and he shoves the train door open. \n"
          print "The two of you scuffle, until he trips you like the underhanded cheater he is. \n"
          print "You fall, trying to drag him with you, but he catches onto the train rail as you slip from the car and onto the tracks.\n"
        elsif @bosshealth > 3
          print "The conductor is panting on his knees. You stand above him, flexing your hand as you prepare to deal the final blow. \n"
          print "He grabs onto your ankle and pulls a lever. The train door slides open automatically and he reaches up to pull on your shirt.\n"
          print "He yanks you down and you fall over him, sliding out the train with a long, curse-filled yell onto the tracks below. \n"
        end
        print "You died."
        break
      end
    end
    #winning screen
    if @bosshealth < 1
      print "With one last wheeze, the conductor falls dead on the ground. \n"
      print "You wince a little and slide the side door open and prod him out with your foot. \n"
      print "He rolls out and lands on the tracks and the train leaves him far behind.\n"
      print "You sit down in the conductor's seat and rest your hand over the brake knob. You do not know how to drive a train.\n"
      print "However... \n"
      print "You have successfully hijacked this train! Congratulations! \n \n"
      print "        ______                 . . . . . o o o o o\n"
      print "      __|[__]|__ ___________ _______    ____      o\n"
      print "      |[] [] []| [] [] [] [] [_____(__  ][]]_n_n__][.\n"
      print "     _|________|_[_________]_[________]_|__|________)<\n"
      print "         oo    oo 'oo      oo ' oo    oo 'oo 0000---oo\_\n"
      print "^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^\n"
      #train art from http://www.won.nl/dsp/usr/mvketel/internet/Asciiart/tprtmain.html
    end
  end
end
