class Customer

    def initialize(customer_details)
        @cust = customer_details
    end

    
    # def update_customer_name(new_name)
    #     @cust['name'] = new_name
    # end

    def save_to_file
        
        filename = 'customers_report.csv'
        customer_file = open(filename,'a')
        customer_file.write(@cust['name'] + ',' + @cust['bankID'] + ',' + @cust['deposit'])
        customer_file.write("\n")
        customer_file.close
        puts "Customer added to file."
        puts "=" * 15
    end
end

    def copy_temp_to_original
        input = File.open('tempo_report.csv','r')
        indata = input.read()

        STDIN.gets

        output = File.open('customers_report.csv', 'w')
        output.write(indata)

        puts "Alright, all done."

        output.close()
        input.close()
    end

$counter = 0
$customer_list = Array.new
    def adding_customer
        puts"enter name, BankID, deposit"
        @name = gets.chomp
        @id = gets.chomp
        @deposit = gets.chomp
        $customer_list[$counter] = Customer.new({ "index" => @counter , "name" => @name , "bankID" => @id, "deposit" => @deposit }) 
        $customer_list[$counter].save_to_file  
        $counter = $counter+1   
    end
    def editing_customer

        require 'csv'
        filename = 'tempo_report.csv'
        customer_file = open(filename,'w')
        
        
        
        puts "enter 1.name 2.bankID"
        @editing_option = gets.chomp
        if @editing_option == "1"
            puts "enter the previous name of the customer"
            @current_name = gets.chomp
            puts "enter the new name"
                @new_name = gets.chomp
            CSV.foreach('customers_report.csv') do |row|
                puts row.inspect
             if row[1] != @current_name
                
                customer_file.write(row)
                customer_file.write("\n")

             else 

                 customer_file.write(row[0] + "," + @new_name + "," + row[2] + "," + row[3] )
                 customer_file.write("\n")

             end
            end
            elsif @editing_option == "2" 
                #same approach but this time with bankID
        else
             puts "incorrect input, select 1 or 2" 
        end
        copy_temp_to_original
        customer_file.close
        puts "file is edited."
        puts "=" * 15
    end

    def saving_money

        require 'csv'
        filename = 'tempo_report.csv'
        customer_file = open(filename,'w')
        
        puts "enter the name"
        @current_name = gets.chomp

        puts "enter the saving amount"
        @depo_amount = gets.chomp.to_i

            CSV.foreach('customers_report.csv') do |row|
                puts row.inspect
             if row[1] != @current_name
                
                customer_file.write(row)
                customer_file.write("\n")

             else 

                 customer_file.write(row[0] + "," + row[1] + "," + row[2] + "," + "row[2].to_i + @depo_amount" )
                 customer_file.write("\n")

             end
            end
            copy_temp_to_original
        customer_file.close

        puts "the saving transaction is complted."
        puts "=" * 15
    
    end
    def withdraw_money

        require 'csv'
        filename = 'tempo_report.csv'
        customer_file = open(filename,'w')
        
        puts "enter the name"
        @current_name = gets.chomp

        puts "enter the withdrawal amount"
        @depo_amount = gets.chomp.to_i

            CSV.foreach('customers_report.csv') do |row|
                puts row.inspect
             if row[1] != @current_name
                
                customer_file.write(row)
                customer_file.write("\n")

             else 

                 customer_file.write(row[0] + "," + row[1] + "," + row[2] + "," + "row[2].to_i - @depo_amount" )
                 customer_file.write("\n")

             end
            end
            copy_temp_to_original 
        customer_file.close

        puts "the transaction is complted."
        puts "=" * 15
    
    end

    def customer_info

        require 'csv'
        filename = 'tempo_report.csv'
        customer_file = open(filename,'w')
        
        puts "enter the name"
        @current_name = gets.chomp

        

            CSV.foreach('customers_report.csv') do |row|
                puts row.inspect
             if row[1] == @current_name
                
                puts row.inspect
                customer_file.write("\n")

             
             end
            end
            
        customer_file.close

        puts "the report for #{@current_name}."
        puts "=" * 15
    
    end

def home_page
    puts "select the request number"
    puts "1.adding customer"
    puts "2.editing data"
    puts "3.deposit money"
    puts "4.withdrawal"
    puts "5.customer info report"

    @option_number = gets.chomp
    case @option_number
        when "1"
            adding_customer
        when "2"
            editing_customer
        when "3"
            saving_money
        when "4"
            withdraw_money
        when "5"
            customer_info
    end   
            
end
@answer = true

while (@answer)
home_page

puts "more request? Y / n"
if ["y","Y"].include? gets.chomp
    @answer = true
else
    @answer = false
end

end




