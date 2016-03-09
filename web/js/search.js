$("#searchsupplierbyname").keyup(function() {
    
    //split the current value of searchInput
    var data = this.value.split(" ");
    //create a jquery object of the rows
    var rowData = $(".supplier");
    if (this.value == "") {
        rowData.hide();
        return;
    }
    //hide all the rows
    rowData.hide();

    //Recusively filter the jquery object to get results.
    rowData.filter(function(index) {
        var $filterText = $(this);
        for (var datum = 0; datum < data.length; ++datum) {
            if ($filterText.text().toLowerCase().indexOf(data[datum].toLowerCase()) > -1) {
                return true;
            }
        }
        return false;
    })
            //show the rows that match.
            .show();
});

$("#searchingredient").keyup(function() {
    //split the current value of searchInput
    var data = this.value.split(" ");
    //create a jquery object of the rows
    var rowData = $(".ingredient");
    if (this.value == "") {
        rowData.hide();
        return;
    }
    //hide all the rows
    rowData.hide();

    //Recusively filter the jquery object to get results. 
    rowData.filter(function(index) {
//        Filter the text only based on the div content
        var $filterText = $(this).children("div.content-itemname");
        for (var datum = 0; datum < data.length; ++datum) {
            if ($filterText.text().toLowerCase().indexOf(data[datum].toLowerCase()) > -1) {
                return true;
            }
        }
        return false;
    })
            //show the rows that match.
            .show();
});

