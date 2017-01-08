#Elizabeth Cepernich
#ecepernich@gmail.com
#CMPS 112 Winter 2016
#Final Project
#3/11/2016

#load item class
load 'Item.rb'

class Inventory
  #initialize inventory with empty list
  def initialize()
    @inventory=[]
  end

  #add item to inventory
  def addItem(item)
    #check if item is empty placeholer item
    if (item.itemName() != "nothing")
      contains=false
      #checks to see if item stacks
      for thing in @inventory
        if item.itemName()==thing.itemName()
          #stack item by updating the item multiplier number
         thing.changeNumber(thing.itemNumber()+item.itemNumber())
         contains=true
       end
      end
      #if item doesn't stack, add to the end of list
     if contains==false
       @inventory << item
     end
    end
    return @inventory
  end

  #remove item from inventory
  def removeItem(item)
    #create new inventory so that the old one doesn't have blank spaces
    newInventory=Inventory.new
    removed=false
    #add all non-specified items to the list
    for thing in @inventory
      if thing.itemName() != item
        newInventory.addItem(thing)
        #if there is multiple of the item you are trying to remove, edit the stack number
      else
        if thing.itemNumber() > 1
          thing.changeNumber(thing.itemNumber()-1)
          newInventory.addItem(thing)
        else
          print ""
        end
        removed=true
      end
    end
    #give updated inventory bac
    return newInventory
  end

  #nice formatting for looking at your inventory
  def showInventory()
    for item in @inventory
      print "["+item.showItem()+"] "
    end
    print "\n"
  end

  #size variable for simplicity
  def inventorySize()
    return @inventory.length
  end

  #contains method checks to see if there are at least x number of a specific item in your inventory
  def contains(item,num)
    contain=false
    for thing in @inventory
      #check if there is that item
      if thing.itemName() == item
        #check if there are at least that number of that item
        if thing.itemNumber >= num
          contain=true
        end
      end
    end
    return contain
  end

  #check inventory contents to see if you can craft a specific item
  def canCraft(inventory,item)
    contain=false
    # a loaded gun is made from a bullet, gunpowder, and an empty gun. your inventory must contain all 3 to craft a loaded gun
    if item .eql? ("loaded gun")
      containsGun=inventory.contains("empty gun",1)
      containsGunpowder=inventory.contains("gunpowder",1)
      containsBullet=inventory.contains("bullet",1)
      contain=containsGun && containsGunpowder && containsBullet
      # a cattle prod is made from two batteries, three wire, and a cane. your inventory must contain all 6 items
    elsif item .eql? ("cattle prod")
      containsCane=inventory.contains("hollow cane",1)
      containsBatteries=inventory.contains("battery",2)
      containsWire=inventory.contains("copper wire",3)
      contain=containsCane && containsBatteries && containsWire
      #a lock pick is made from one wire and one piece of scrap metal. your inventory must contain both
    elsif item .eql? ("lock pick")
      containsMetal=inventory.contains("scrap metal",1)
      containsWire=inventory.contains("copper wire",1)
      contain=containsWire && containsMetal
    else
      #catch misspellings
      print "You cannot craft a ",item," in this game.\n"
    end
    return contain
  end

  #make things!
  def craft(inventory,item)
    #error check
    if inventory.canCraft(inventory,item) == false
      print "You cannot craft a ",item,".\n"
    else
      #add a loaded gun item and remove the empty gun and gunpowder. you keep the bullet because you use it to fire
      #it's just required to make a loaded gun because a gun without a bullet isn't loaded
      if item == "loaded gun"
        inventory=inventory.removeItem("empty gun")
        inventory=inventory.removeItem("gunpowder")
        loadedGun=Item.new("loaded gun",1)
        inventory.addItem(loadedGun)
      #add a cattle prod item and remove the batteries, wire, and cane
      elsif item == "cattle prod"
        inventory=inventory.removeItem("hollow cane")
        inventory=inventory.removeItem("copper wire")
        inventory=inventory.removeItem("copper wire")
        inventory=inventory.removeItem("copper wire")
        inventory=inventory.removeItem("battery")
        inventory=inventory.removeItem("battery")
        cattleProd=Item.new("cattle prod",1)
        inventory.addItem(cattleProd)
      #add a lock pick item and remove the wire and the scrap metal
      elsif item == "lock pick"
        inventory=inventory.removeItem("scrap metal")
        inventory=inventory.removeItem("copper wire")
        lockpick=Item.new("lock pick",1)
        inventory.addItem(lockpick)
      else
        #error catch
        print "Error?\n"
      end
      #success message
      print "You have crafted a ",item,". It is now in your inventory.\n"
    end
    #return inventory to update it
    return inventory
  end
end
