class Customer

    def initialize(customer_details)
        @cust = customer_details
    end

    def print_customer_details()
        puts "Customer details:"
        puts "Name: #{@cust['name']}"
        puts "Starsign: #{@cust['starsign']}"
        puts "Age: #{@cust['age']}"
        puts "=" * 15
    end

    def update_customer_name(new_name)
        @cust['name'] = new_name
    end

    def save_to_file
        filename = 'customers.csv'
        customer_file = open(filename,'a')
        customer_file.write(@cust['name'] + ',' + @cust['starsign'] + ',' + @cust['age'].to_s)
        customer_file.write("\n")
        customer_file.close
        puts "Customer added to file."
        puts "=" * 15
    end
end

def read_from_file
    filename = 'customers.csv'
    customer_file = File.open(filename, 'r')
    customer_file.each {|line| print line }
end


pedro = Customer.new({ "name" => "Pedro", "starsign" => "Taurus", "age" => 21 })

jake = Customer.new(
     { "name" => "Jake", "starsign" => "Aries", "age" => 23 }
    )
  
read_from_file

customers = [pedro, jake]
customers.each do |customer|
    customer.print_customer_details()
    customer.save_to_file
end