#Elizabeth Cepernich
#ecepernich@gmail.com
#CMPS 112 Winter 2016
#Final Project
#3/11/2016

#interaction uses all these classes
load 'Item.rb'
load 'Inventory.rb'
load 'Person.rb'

class Interaction
  #interaction isn't an object, but more of a group of options, so nothing to initialize
  def initialize()

  end

  #show user position on a train map for reference
  def map(position)
    p=[" "," "," "," "," "," "," "," "," "]
    p[position-1]="X"
    print "|     | |     | |     | |     | |     | |     | |     | |     |\n"
    print "|  ",p[8],"  |=|  ",p[7],"  |=|  ",p[6],"  |=|  ",p[4],"  |=|  ",p[3],"  |=|  ",p[2],"  |=|  ",p[1],"  |=|  ",p[0],"  |O<\n"
    print "|_____| |_____| |_____| |_____| |_____| |_____| |_____| |_____|\n"
  end

  #compare a person's wanted item to your inventory to see if you have it
  def canTrade(person,inventory)
    person_wants=person.personWants()
    name=person_wants.itemName()
    #check contains function to see if inventory contains item
    possibleTrade=inventory.contains(name,1)
  end

  #trade method does the actual trading, uses canTrade()
  def trade(person,inventory)
    #uses interaction to call own methods
    interaction=Interaction.new()
    if (interaction.canTrade(person,inventory)==true)
      person_wants=person.personWants()
      person_has=person.personHas()
      #add item person has
      inventory.addItem(person_has)
      #remove item person wants
      inventory.removeItem(person_wants.itemName())
      #update person item variable
      person.givePerson(person_wants)
      #add nothing placeholder
      nothing=Item.new("nothing",0)
      person.initPersonWants(nothing)
      #success message
      print "You have traded ",person_wants.showItem()," for ",person_has.showItem(),".\n"
    else
      #failure method
      print "You don't have the right items to trade with ",person.personName(),".\n"
    end
    return inventory
  end

  #get information - vestigaes of hopeful function that never came to be
  def ask(person)
    if (person.isEvil() == false)
      print person.getInfo()
    else
      person.anger()
    end
  end

  #updates a person's alive status to dead
  def kill(person)
    person.killPerson()
  end

  #steal function just removes item from person and adds them to player inventory - much simpler than trade
  def steal(person,inventory)
    if (person.isEvil() == false)
      person_has=person.personHas()
      #add person's item to player inventory
      inventory.addItem(person_has)
      #add nothing placeholder to person
      nothing=Item.new("nothing",0)
      person.givePerson(nothing)
      #success message
      print "You have successfully stolen ",person_has.showItem(),". It is now in your inventory.\n"
    end
    if person.isAsleep() == false
      person.anger()
    end
  end

  #same as steal function, without the morality check
  def loot (person,inventory)
    if (person.isAlive() == false)
      person_has=person.personHas()
      inventory.addItem(person_has)
      nothing=Item.new("nothing",0)
      person.givePerson(nothing)
    else
      print "You can't loot a live person. Sorry about that.\n"
    end
  end

  #shoot function shows up in the final fight
  def shoot(inventory)
    #make sure you actually have a functional loaded gun
    canfire=inventory.contains("bullet",1) && inventory.contains("loaded gun",1)
    if canfire == true
      #shooting a bullet removes it from your inventory. status messages
      inventory=inventory.removeItem("bullet")
      if inventory.contains("bullet",1)
        print "You fired your gun. You lose one bullet from your inventory.\n"
      else
        #if you shoot your last bullet, remove loaded gun item and replace it with empty gun item. status message
        inventory=inventory.removeItem("loaded gun")
        newgun=Item.new("empty gun",1)
        inventory.addItem(newgun)
        print "You fired your gun. You ran out of bullets, so your gun is new empty.\n"
      end
    else
      #error message
      print "You cannot shoot.\n"
    end
    #return inventory in case of last bullet shooting
    return inventory
  end
end
