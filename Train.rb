#Elizabeth Cepernich
#ecepernich@gmail.com
#CMPS 112 Winter 2016
#Final Project
#3/11/2016

#load every class! this is the game!
load 'Item.rb'
load 'Inventory.rb'
load 'TrainCar.rb'
load 'Person.rb'
load 'Interaction.rb'
load 'Fight.rb'

class Train
  #make train
  one=TrainCar.new(1)
  two=TrainCar.new(2)
  three=TrainCar.new(3)
  four=TrainCar.new(4)
  five=TrainCar.new(5)
  #removed six
  seven=TrainCar.new(7)
  eight=TrainCar.new(8)
  nine=TrainCar.new(9)
  #link cars back
  one.linkBack(two)
  two.linkBack(three)
  three.linkBack(four)
  four.linkBack(five)
  five.linkBack(seven)
  #removed six
  seven.linkBack(eight)
  eight.linkBack(nine)
  #link cars forward
  two.linkFront(one)
  three.linkFront(two)
  four.linkFront(three)
  five.linkFront(four)
  #removed six
  seven.linkFront(five)
  eight.linkFront(seven)
  nine.linkFront(eight)

  #create items to populate train and people
  wire3=Item.new("copper wire",3)
  wire6=Item.new("copper wire",6)
  bullet=Item.new("bullet",3)
  gun=Item.new("empty gun",1)
  gunpowder=Item.new("gunpowder",1)
  cane=Item.new("hollow cane",1)
  metal=Item.new("scrap metal",3)
  battery=Item.new("battery",4)
  batteries=Item.new("battery",2)
  gunspowders=Item.new("gunpowder",10)
  scraps=Item.new("scrap metal",1)
  nothing=Item.new("nothing",0)
  inventory=Inventory.new()
  interaction=Interaction.new()

  #create people
  gansey=Person.new()
  gansey.namePerson("Richard Gansey")
  gansey.givePerson(cane)
  gansey.initPersonWants(nothing)
  gansey.putToSleep()
  gansey.tellPerson("Richard Gansey is asleep.\n")
  larry=Person.new()
  larry.namePerson("Shifty Larry")
  larry.givePerson(metal)
  larry.initPersonWants(batteries)
  larry.tellPerson("I heard that that ol' hobo in the next car up's gotta gun.\nYou can take it, but ya gotta be fast. He don't like trading for nothing.\n")
  hobo=Person.new()
  hobo.namePerson("The Hoboken Hobo")
  hobo.givePerson(gun)
  hobo.initPersonWants(nothing)
  hobo.putToSleep()
  hobo.tellPerson("The Hoboken Hobo is asleep.\n")
  baddie=Person.new()
  baddie.namePerson("Chester Bennington")
  baddie.givePerson(gun)
  baddie.initPersonWants(wire3)
  baddie.tellPerson("The front car is locked. If you want to get to the driver, you'll need a lock pick.\n")
  baddie.makeEvil()

  #populate cars
  nine.addItemToCar(bullet)
  nine.addItemToCar(wire3)
  nine.addItemToCar(gunpowder)
  nine.addItemToCar(battery)
  eight.addPersonToCar(larry)
  seven.addPersonToCar(hobo)
  five.addPersonToCar(baddie)
  four.addPersonToCar(gansey)
  two.addItemToCar(wire6)
  two.addItemToCar(batteries)
  three.addItemToCar(gunspowders)
  three.addItemToCar(scraps)

  #special edits
  one.lock()
  five.lock()
  @current=nine
  endgame=false
  helpstring="Commands: \n'l' - go left \n'r' - go right \n'look' - look around the train car \n'take' - take something you find in the train car\n'interact' - interact with people in the train car \n'map' - show your position on the map \n'inventory' - check your inventory \n'craft' - make things out of items you have found \n'help' - print these commands again \n'exit - quit the game' \n"
  print helpstring

  #start game
  puts "Enter a command: "
  choice=gets.chomp()
  while (choice != "exit")
    #move left
    if choice.eql?("l")
      if (@current.backCar() != nil)
        @current=@current.backCar()
        interaction.map(@current.showName())
      #end of train - can't move
      else
        @current=@current
        print "You can't go back, you'll fall out the train!\n"
      end
      #move right
    elsif choice.eql?("r")
      #move
      if (@current.frontCar() != nil && @current.frontCar.isLocked() == false)
        @current=@current.frontCar()
        interaction.map(@current.showName())
        #lock picking exception - uses lock pick method from traincar
      elsif (@current.frontCar() != nil && @current.frontCar.isLocked() == true)
        puts "This car is locked. Do you want to try picking the lock? (yes/no) "
        yesno=gets.chomp()
        if yesno .eql? "yes"
          inventory=@current.frontCar().pickLock(inventory)
        else
          @current=@current
        end
        #end of train - can't move
      else
        @current=@current
        print "You can't go forward, you'll fall out the train!\n"
      end
      #print position on map using map interaction
    elsif choice .eql? ("map")
      interaction.map(@current.showName())
      #use crafting methods from Inventory class
    elsif choice .eql? ("craft")
      craftGun=inventory.canCraft(inventory,"loaded gun")
      craftProd=inventory.canCraft(inventory,"cattle prod")
      craftPick=inventory.canCraft(inventory,"lock pick")
      #show crafting ingredients
      if (craftGun or craftProd or craftPick)
        print "Given your current inventory, you can craft: \n"
        if (craftGun)
          print "a loaded gun, out of an empty gun, gunpowder, and a bullet \n"
        end
        if (craftProd)
          print "a cattle prod, out of a hollow cane, two batteries, and three wire \n"
        end
        if (craftPick)
          print "a lock pick, out of wire and a metal shard\n"
        end
        print "What do you want to do? (craft/stop) "
        #check if user wants to craft
        craftstop=gets.chomp()
        if craftstop .eql? "craft"
          print "What do you want to craft? "
          craft=gets.chomp()
          #use crafing method of Inventory
          inventory=inventory.craft(inventory,craft)
        end
      else
        print "You don't have the right items to craft anything. Go look for stuff.\n"
      end
      #look shows a car's inventory and people
    elsif choice .eql? ("look")
      @current.carInventory().showInventory()
      if (@current.showPeople() != "None")
        print @current.showPeople().showPerson()
      end
      #take removes items from a car inventory - not people
    elsif choice .eql? ("take")
      #check empty car
      if (@current.carInventory.inventorySize() == 0)
        print "This car has no free items to take.\n"
        #get item you want to take
      else
        puts "What do you want to take? "
        toTake=gets.chomp()
        #get how many you want to take - this was initially added because it was tedious during testing to
        #repeatedly type "take" for the same item but i kept it in because i doubt you'll want to do it either
        if @current.carInventory.contains(toTake,1)
          puts "How many do you want to take? "
          howMany=gets.chomp()
          howMany=Integer(howMany)
          #removes the requested number of items from the car inventory
          if (@current.carInventory.contains(toTake,howMany) && howMany > 0)
            for i in 0...howMany
              @current.removeItemFromCar(toTake)
            end
            #add new stack of items to player inventory
            item=Item.new(toTake,howMany)
            inventory.addItem(item)
            #success message
            print "You have taken ",toTake," (x",howMany,"). It is now in your inventory. \n"
          else
            #error message
            print "You cannot take ",howMany," ",toTake,". Try again.\n"
          end
        else
          #error message
          print "This car does not contain that item.\n"
        end
      end
      #show inventory using Inventory method
    elsif choice .eql? ("inventory")
      inventory.showInventory()
      #interact with people using person methods
    elsif choice .eql? ("interact")
      if @current.showPeople() == "None"
        print "There is no one to interact with in this train car."
      else
        currentPerson=@current.showPeople()
        #story line
        print "You approach ",currentPerson.personName(),"\n"
        if currentPerson.isAsleep() == true
          print currentPerson.personName(),"is asleep.\n"
        #if person isn't asleep, you get trade info. can't trade with sleeping people
        else
        print currentPerson.personName()," is currently carrying ",currentPerson.personHas().showItem()," and is willing to trade for ",currentPerson.personWants().showItem(),".\n"
        end
        print "What do you want to do? (talk, trade, steal, kill) "
        humanInteraction=gets.chomp()
        #if perosn is awake, return person's info var
        if (humanInteraction == "talk")
          if currentPerson.isAsleep() == true
            print currentPerson.personName()," is asleep. You can't talk to someone who is asleep. \n"
          else
            interaction.ask(currentPerson)
          end
          #use interaction trade method to trade with a person
        elsif (humanInteraction == "trade")
          if currentPerson.isAsleep() == true
            print currentPerson.personName()," is asleep. You can't trade with someone who is asleep. \n"
          else
            inventory=interaction.trade(currentPerson,inventory)
          end
          #use interaction steal method to steal from a person
        elsif (humanInteraction == "steal")
          interaction.steal(currentPerson,inventory)
          #use interaction kill method to kill a person
        elsif (humanInteraction == "kill")
          interaction.kill(currentPerson)
          print "You killed ",currentPerson.personName(),"!\n"
          #check if you want to loot (morals? what morals?)
          print "Do you want to loot their corpse before someone discovers it? (yes/no) "
          yesno=gets.chomp()
          if yesno .eql? ("yes")
            #use interaction loot method
            interaction.loot(currentPerson,inventory)
            print "You looted ",currentPerson.personName(),"'s dead body.\n"
          end
          #car updates to remove person so you can no longer interact with them
          @current.removePersonFromCar()
        else
          #error message
          print "Invalid command. \n"
        end
      end
    else
      #error message
      print "Invalid command. Try again.\n"
    end
    #check if fight. the fight happens as soon as you reach car one and that is the end of the game
    if (@current.showName() == 1)
      fight=Fight.new()
      #use fight method, using player inventory
      fight.bossFight(inventory)
      endgame=true
      break
    end
    #check if fight is done. if not, get new command. if so, exit command, which ends the loop and the game
    if (endgame == false)
      puts "Enter a command: "
      choice=gets.chomp()
    else
      choice="exit"
    end
  end
end
