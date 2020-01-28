def find_item_by_name_in_collection(name, collection)
  i = 0
  while i < collection.length do
    if name === collection[i][:item]
      return collection[i]
    else 
      i += 1
    end
  end
  nil
end


def consolidate_cart(cart)
  con_cart = []
  index = 0
  while index < cart.length do
    item = cart[index][:item]
    duplicate = find_item_by_name_in_collection(item, con_cart)
    if duplicate
      duplicate[:count] += 1
    else
      cart[index][:count] = 1
      con_cart << cart[index]
    end
    index+=1
  end
  con_cart
end

def apply_coupons(cart, coupons)
  index=0
  while index < coupons.count do
    coupon = coupons[index]
    discount_price = (coupon[:cost].to_f / coupon[:num].to_f).round(2)
    discount_item = find_item_by_name_in_collection(coupon[:item], cart)
    if discount_item && (coupon[:num] <= discount_item[:count])
      discount_item[:count] -= coupon[:num]
      item_with_coupon = {item: coupon[:item] += " W/COUPON", price: discount_price, clearance: discount_item[:clearance], count: coupon[:num]}
      cart << item_with_coupon
    end
    index+=1
  end
  cart
end

def apply_clearance(cart)
  index=0
  while index < cart.length do
    item = cart[index]
    if item[:clearance]
      item[:price] = (item[:price] * 0.8).round(2)
    end
    index+=1
  end
  cart
end


def checkout(cart, coupons)
  new_cart = consolidate_cart(cart)
  apply_coupons(new_cart, coupons)
  apply_clearance(new_cart)
  index = 0
  grant_total = 0
  while index < new_cart.length do
    grand_total = (new_cart[index][:count] * new_cart[index][:price]).round(2)
    index += 1
  end
  grand_total >= 100 ? (grand_total * 0.9).round(1) : grand_total
end
