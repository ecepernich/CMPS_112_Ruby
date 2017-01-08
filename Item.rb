#Elizabeth Cepernich
#ecepernich@gmail.com
#CMPS 112 Winter 2016
#Final Project
#3/11/2016


#item class - doesn't need to import anything

class Item
  #all items have a name and multiplier
  def initialize(name, num)
    @item_name=name
    @item_number=num
  end

  #showitem method takes into account stacking
  def showItem()
    showstring="#@item_name"
    if @item_number > 1
      showstring=showstring+" (x#@item_number)"
    else
      showstring=showstring
    end
    return showstring
  end

  #get an item's name
  def itemName()
    return "#@item_name"
  end

  #get an item's multiplier
  def itemNumber()
    return @item_number
  end

  #update an item's name
  def changeName(name)
    @item_name = name
  end

  #update an item's multiplier
  def changeNumber(num)
    @item_number = num
  end
end
