<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<table class="page">
	<td>
		<button type="button" key="1">首页</button>
		<button type="button" <c:if test="${pageInfo.firstPage == true}">disabled</c:if> key="${pageInfo.prePage}">上一页</button>
		${pageInfo.pageNo}/${pageInfo.totalPage}
		<button type="button" <c:if test="${pageInfo.lastPage == true}">disabled</c:if>  key="${pageInfo.nextPage}">下一页</button>
		<button type="button" key="${pageInfo.totalPage}">尾页</button>
		<input  type="number" min="1" class="page-no"  id="page-no" value="${pageInfo.pageNo}" />
		<button type="button" class="zhuan">转</button>
		总${pageInfo.totalCount}条,每页${pageInfo.pageSize}条数据
	</td>
</table>
<script type="text/javascript">

	$(function(){
		$('.page .zhuan').click(function(){
			if(parseInt($('#page-no').val())<=parseInt("${pageInfo.totalPage}")){
				$('input[name="pageNo"]').val($('#page-no').val());
				$("#tableList").submit();
			}else{
				alert("不能大于总页数");
			}
		});
		$('.page button:not(.zhuan)').click(function(){
			$('input[name="pageNo"]').val($(this).attr("key"));
			$("#tableList").submit();
		})
	})
</script>