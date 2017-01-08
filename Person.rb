#Elizabeth Cepernich
#ecepernich@gmail.com
#CMPS 112 Winter 2016
#Final Project
#3/11/2016

#load item and inventory class - people have items and interact with player inventories
load 'Item.rb'
load 'Inventory.rb'

class Person
  #a person has lots of variables - some didn't get really implemented
  def initialize()
    @name=""
    @has=nil
    @wants=nil
    @alive=true
    @evil=false
    @hostile=false
    @info=""
    @asleep=false
  end

  #initialize - assign person values in other classes
  def namePerson(name)
    @name=name
  end
  def initPersonWants(item)
    @wants=item
  end
  def givePerson(item)
    @has=item
  end
  def tellPerson(info)
    @info=info
  end
  def makeEvil
    @evil=true
  end
  def makeGood()
    @evil=false
  end
  def killPerson()
    @alive=false
  end
  def anger()
    @hostile=true
  end
  def calm()
    @hostile=false
  end
  def putToSleep()
    @asleep=true
  end

  #get - receive person values in other classes
  def personName()
    return @name
  end
  def personWants()
    return @wants
  end
  def personHas()
    return @has
  end
  def isEvil()
    return @evil
  end
  def isAlive()
    return @alive
  end
  def getInfo()
    infostring=@name
    infostring=infostring+" says: "
    infostring=infostring+@info
    return infostring
  end
  def isHostile()
    return @hostile
  end
  def isAsleep()
    return @asleep
  end

  #actions - this used to be for test purposes but is used as a get method instead
  def showPerson()
    print @name,"\n"
  end
end
