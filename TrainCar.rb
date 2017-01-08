#Elizabeth Cepernich
#ecepernich@gmail.com
#CMPS 112 Winter 2016
#Final Project
#3/11/2016

#import item and inventory to populate traincar
load 'Item.rb'
load 'Inventory.rb'

#this is the linked list part - the train cars are the nodes
class TrainCar
  #initialize train car as empty
  def initialize(name)
    @id=name
    contents=Inventory.new
    @contents=contents
    @front=nil
    @back=nil
    @people="None"
    @locked=false
  end

  #link node forward
  def linkFront(front_car)
    @front=front_car
  end

  #link node back
  def linkBack(back_car)
    @back=back_car
  end

  #get train car name for lock check purposes
  def showName()
    return @id
  end

  #return lock variable
  def isLocked()
    return @locked
  end

  #update lock variable
  def lock()
    @locked=true
  end

  def unlock()
    @locked=false
  end

  #shows all items in the car, if there are any
  def carInventory()
    return @contents
  end

  #show the person in the car, if there is one
  def showPeople()
    return @people
  end

  #method from testing purposes
  def showCar()
    str=@id
    print "This car is car #",str,"\n"
    if @front != nil
      print "The front car is #",@front.showName(),"\n"
    end
    if @back != nil
      print "The front car is #",@back.showName(),"\n"
    end
    inventory=@contents
    inventory.showInventory()
    print "\n"
    if (@people != "None")
      print @people.showPerson()
    end

    print "\n"
  end

  #update car inventory using Inventory method
  def addItemToCar(item)
    @contents.addItem(item)
  end

  def removeItemFromCar(item)
    @contents=@contents.removeItem(item)
  end

  #add fully created person to car
  def addPersonToCar(person)
    @people=person
  end

  #really just set person variable to empty
  def removePersonFromCar()
    @people="None"
  end

  #methods for moving around, since ruby doesn't like using the initialized variables on their own
  def frontCar()
    return @front
  end
  def backCar()
    return @back
  end

  #two cars (6 and 1) need lock picks. this is an easy recallable method to pick a lock and remove the lock pick from the inventory
  def pickLock(inventory)
    #if user has a lock pick, update locked variable to unlocked and remove the lock pick from the inventory
    #success message
    if inventory.contains("lock pick",1)
      @locked=false
      print "You have picked the lock. The car is now open. \n"
      print "However, picking the lock broke your lock pick \n"
      inventory=inventory.removeItem("lock pick")
    else
      print "You can't unlock this car without a lock pick.\n"
    end
    #return inventory from lock pick removal
    return inventory
  end
end
