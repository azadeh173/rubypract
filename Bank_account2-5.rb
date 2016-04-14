class Accounts


    def initialize(account_details)
         @acc_detail = account_details
         

    end

    def save_transactions
        
        filename = 'transactions_info.csv'
        acc_file = open(filename,'a')
        acc_file.write(@acc_detail['name'] + ',' + @acc_detail['bankID'] + ',' + @acc_detail['deposit'] + ',' + @acc_detail['date_time'].to_s)
        acc_file.write("\n")
        acc_file.close
        puts "Transaction is added to the file."
        puts "=" * 15

    end

end

#======Class Customer===========
# creates instances of customers 
# saves their details in a file named customers_report

class Customer

    def initialize(customer_details)
        @cust = customer_details
    end

    def save_to_file
        
        filename = 'customers_report.csv'
        customer_file = open(filename,'a')
        customer_file.write(@cust['name'] + ',' + @cust['bankID'] + ',' + @cust['deposit'])
        customer_file.write("\n")
        customer_file.close
        puts "Customer is added to the file."
        puts "=" * 15


    end
end

#=======method copy_temp_to_original
#===over rights the cutomers_report to apply changesf 

    def copy_temp_to_original

         require 'csv' 
          File.truncate('customers_report.csv', 0)

         filename4 = File.open('tempo_report.csv').read
         filename5 = 'customers_report.csv'
         file_name5 = open(filename5,'a')

         filename4.each_line do |line|
         file_name5 << line
         end
        file_name5.close
    end

$counter = 0
$customer_list = Array.new

#====adding_customers====
#====Adds someone new

    def adding_customer
        @current_time = Time.now
        puts"enter name, BankID, deposit"
        @name = gets.chomp
        @id = gets.chomp
        @deposit = gets.chomp
        @new_account= Accounts.new({'name'=> @name, "bankID" => @id, "deposit" => @deposit, "date_time" => @current_time})
        @new_account.save_transactions
        $customer_list[$counter] = Customer.new({ "name" => @name , "bankID" => @id, "deposit" => @deposit }) 
        $customer_list[$counter].save_to_file  
        $counter = $counter+1  
       
    end

#====editing customer
#====modifies data about customers

    def editing_customer

        require 'csv'
        filename = 'tempo_report.csv'
        customer_file = open(filename,'w') 
        filename = 'customers_report.csv'
        customer_file2 = open(filename,'r+')     
        puts "enter 1.name 2.address 3.phone number"
        @editing_option = gets.chomp
        case @editing_option 
        when "1"

            puts "enter the previous name of the customer"
            @current_name = gets.chomp
            puts "enter the new name"
                @new_name = gets.chomp
            CSV.foreach('customers_report.csv') do |row|
                
             if row[0] != @current_name
                
                customer_file.write(row[0] + "," + row[1] + "," + row[2])
                customer_file.write("\n")
             else 
                customer_file.write( @new_name + "," + row[1] + "," + row[2] )
                customer_file.write("\n")
             end
            end
        when "2" 
                #the same approach but this time with bankID

        end
               
        customer_file.close
        customer_file2.close
        copy_temp_to_original
        puts "file is edited."
        puts "=" * 15

    end

#===========Transactions=======
# for executing tasks related to transactions
    
    def transaction

        require 'csv'
        filename = 'tempo_report.csv'
        customer_file = open(filename,'w')
        
        puts "enter name of the customer"
        @current_name = gets.chomp

        puts "purpose of this transaction? 1.to deposit or 2. to withdraw "
        @answer = gets.chomp
        puts "enter the amount of money in AUD"
        @depo_amount = gets.chomp.to_i
        @current_time = Time.now

        case @answer
            when "1"
                @depo_amount_numbers = 0 + @depo_amount
            when "2"
                @depo_amount_numbers = 0 - @depo_amount
        end
            CSV.foreach('customers_report.csv') do |row|
                
             if row[1] != @current_name
                
                customer_file.write(row[0] + "," + row[1] + "," + row[2])
                customer_file.write("\n")

             else 

                customer_file.write(row[0] + "," + row[1] + "," + (row[2].to_i + @depo_amount).to_s)
                customer_file.write("\n")
                 @new_account= Accounts.new({'name'=> @name, "bankID" => @id, "deposit" => @deposit, "date_time" => @current_time})
                 @new_account.save_transactions
             end
            end
            copy_temp_to_original
        customer_file.close

        puts "the saving transaction is complted."
        puts "=" * 15
    
    end

# =====customer info
# gives information about the requested customer

    def customer_info

        require 'csv'
        filename = 'tempo_report.csv'
        customer_file = open(filename,'w')
        
        puts "enter the BankID"
        @current_ID = gets.chomp

        

            CSV.foreach('customers_report.csv') do |row|

                
             if row[1] == @current_ID
                @target_name = row[0]
                puts row.inspect
                customer_file.write("\n")
 
             end
            end
            
        customer_file.close

        puts "the report for #{@target_name}."
        puts "=" * 15
    
    end

# ====transaction report
#    creates reports of transactions for a specific customer

def transactions_report
    require 'csv'
        filename = 'partial_transactions_report.csv'
        transaction_file = open(filename,'w')
        
        puts "enter the BankID"
        @current_ID = gets.chomp

        

            CSV.foreach('transactions_info.csv') do |row|
                
             if row[1] == @current_ID

                transaction_file.write(row)
                transaction_file.write("\n")

             
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
    puts "3.transactions"
    puts "4.transactions_report"
    puts "5.customer info report"

    @option_number = gets.chomp
    case @option_number
        when "1"
            adding_customer
        when "2"
            editing_customer
        when "3"
            transaction
        when "4"
            transactions_report
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




