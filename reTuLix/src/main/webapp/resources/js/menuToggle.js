$(function() {

	var flag=true;

	$("#menuToggle").on("click", function(){
		if(flag==true){
			//$(".sideNav").fadeOut();
			$(".sideNav").animate({left:"-=250"},100);

			$(".main").animate({
				marginLeft:"-=250px"
			},30)
			flag=false;
		} else {
			//$(".sideNav").fadeIn();
			$(".sideNav").animate({left:"+=250"},100);

			$(".main").animate({
				marginLeft:"+=250px"
			},30)
			flag=true;
		}
	})
	
});

 /* 구독리스트 숨기기 */
$(function(){

	 if ($('.moreSub').length > 7) {
		 $('.moreSub').hide();
		 $('.moreSub').slice(0, 7).show();
	 }
	 $('.more').click(function () {
		 if ($(".moreSub").eq(7).is(":hidden")) {
			 $(".moreSub").show(1500);
		 } else {

			 $(".moreSub:gt(6)").slideToggle(1500);
		 }
	 });

}); 	

//정렬하기 

$(function(){
	$('#alignButton').on("click", function(){
		//alert($("#g_button").val());
		if ($("#g_button").val()=='click'){
			window.location.href="clickAlign";
		}else if ($("#g_button").val()=='good'){
			window.location.href="goodAlign";
		}
	})
	
	
})
    