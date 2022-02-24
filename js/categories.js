$(document).ready(function(){
    const categoryidfield=$("#categoryid"), // document.querySelector("#categoryid")
            categorynamefield=$("#categoryname"),
            savebutton=$("#savecategory"),
            errormessagelocation=$(".errormessages")

    // savebutton.addEventListener("click",function(){

    // })

    savebutton.on("click",function(){
        
        const categoryid=categoryidfield.val(), //categoryid=categoryidfield.value
                categoryname=categorynamefield.val()
        let errors=""            
        // check if blank fields
        if(categoryname===""){
            errors="Please provide category name"
        }
        
        if(errors===""){
            // save the category
            $.post(
                "../controllers/categoryoperations.php",
                {
                    savecategory:true,
                    categoryid, // categoryid:categoryid
                    categoryname
                },
                function(data){
                  data=$.trim(data)  // data.trim()
                  if(data=="exists"){
                        errormessagelocation.html("Sorry, the category exists in the system")
                  }else if(data==="success"){
                        errormessagelocation.html("Category saved successfully")  

                  }else{
                        errormessagelocation.html(`Sorry an error occured. ${data}`)
                        categorynamefield.val("")
                  }
                }
            )
        }else{
            // display the error
            console.log(errors)
            errormessagelocation.html(errors)
        }
    })

    categorynamefield.on("input",function(){
        errormessagelocation.html("")
    })
    
})