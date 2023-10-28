import os

def get_table_name(statement):
    start_index = statement.index("${database_name}")
    modified_statement = statement[start_index:]
    #print("modified_statement :",modified_statement)
    if modified_statement.index(' ')< modified_statement.index('\n'):
        end_index = modified_statement.index(' ')
    else:
        end_index = modified_statement.index('\n')
    #print("end index :",end_index)
    table_name = modified_statement[:end_index]
    #print("table_name is :",table_name)
    return table_name

def get_new_statement(statement):
    table_name = get_table_name(statement)
    count_statement = "select count(*) from "+table_name+';'
    new_statement = statement.replace("insert",count_statement+"\n"+"insert")
    final_new_statement = new_statement +";\n" + count_statement
    return final_new_statement

def main():
    dir_list = os.listdir("load_scripts")
    #print(dir_list)
    for sql_file in dir_list:
        new_content='' 
        with open("./load_scripts/"+sql_file,"r") as f:
            sqlfile = f.read()
        sqlcommands = sqlfile.split(';')
        #print(sqlcommands)
        for statement in sqlcommands:
            if statement.lstrip().lower().find('insert') >=0 :
                new_statement = get_new_statement(statement)
                new_content = new_content + new_statement
            else:
                new_content= new_content+ statement
            
        with open("./modified_scripts"+sql_file,"w") as f:
            f.write(new_content)
                
if __name__ == "__main__":
    main()