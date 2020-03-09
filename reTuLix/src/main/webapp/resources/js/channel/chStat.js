/*$(function(){
	$("#btSearch").click(function(){
		if($("#search").val()==""){
			alert('검색어를 입력하세요');
			return;
		}
		$("#statSearch").submit;
	})
})
*/
function statReviewSearch(){
	if(!statSearch.statKeyword.value){
		alert("검색어를 입력하세요");
		stat.Search.statKeyword.focus();
		return false;
	}
	statSearch.submit;
}