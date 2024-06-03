document.addEventListener('DOMContentLoaded', function() {
    var listBody = document.querySelector('.list_body');
    var listItems = listBody.querySelectorAll('li');
    var num = ${total} - ((${pageMaker.cri.pageNum} - 1) * ${pageMaker.cri.amount});

    listItems.forEach(function(item) {
        item.querySelector('.num').textContent = num;
        num--;
    });
});