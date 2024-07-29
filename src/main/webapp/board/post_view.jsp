<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>    

<%@ include file="../include/header.jsp" %>

<div id="wrapped">
    <div class="board-type">
        <p>게시판 종류</p>
    </div>
    <div class="post">
        <div class="user-bigbox">
            <img src="../resources/img/userCircle.png" alt="userCircle" style="width: 45px;">
            <div class="user-box">
                <div class="user">
                    <p>익명</p>
                    <p>10분전</p>
                </div>
            </div>
        </div>

        <h3>${dto.title}</h3>
        <p class="post-content">${dto.content}</p>

        <div class="post-info">
            <span class="icon" style="height: 0px; display: inline-block;">
                <span class="material-symbols-outlined" style="font-size:18px;">
                    visibility
                </span>
            </span>
            <span class="num">${dto.viewCount}</span>
            <button class="icon">
                <span class="material-symbols-outlined" style="font-size:18px;">
                    thumb_up
                </span>
            </button>
            <span class="num">${dto.likeCount}</span>
            <button class="icon">
                <span class="material-symbols-outlined" style="font-size:18px;">
                    chat
                </span>
            </button>
            <span class="num">2</span>
        </div>
    </div>
    <div class="comment-bigbox">
    	<%-- 댓글 입력창 --%>
    	<form action="commentWrite.board" method="post">
	    	<span class="comment-input">
	    		<input type="hidden" name="boardId" value="${dto.boardId}">
	    		<input type="hidden" name="postNo" value="${dto.postNo}">
	            <input type="text"  name="commentContent"></input>
	            <button type="submit"><span class="material-symbols-outlined" style="font-size:18px;"> edit</span></button>
	        </span>
    	</form>
        <div class="comment-box">
       		<%-- 댓글 출력 --%>
		    <c:forEach var="comment" items="${commentList}">
		    	<div class="comment  ${comment.parentId != null ? 'reply' : ''}" style="margin-left: ${comment.parentId == null ? '0' : '20'}px;">
			        <div class="user-bigbox flex">
			        	<img src="../resources/img/userCircle.png" alt="userCircle" style="width: 45px;">
			        	<div class="user-box flex flex-1">
                        	<div class="user flex flex-col">
	                            <p>익명 
		                            <c:if test="${dto.userNo == comment.userNo}">
	            						<span>작성자</span>
	        						</c:if>
        						</p>
	                            <p>10분전</p>
	                        </div>
	                    </div>
	                    <div class="flex">
                    	<div class="comment-icon">
                    		<span class="icon">
			               		<span class="material-symbols-outlined" style="font-size:18px;">
			                    	thumb_up
			                	</span>
		            		</span>	
		            		<span class="num">23</span>
                    	</div>
                    </div>
	                </div>
	              	<p class="comment-content">
	                    ${comment.commentContent}
	                </p>
	                 <%-- 대댓글 입력창 --%>
                	<button class="reply-write-btn ${comment.parentId != null ? 'hidden' : ''}">
            			댓글 달기
            		</button>
            		<div class="reply-write reply hidden">
	            		<div class="flex">
	            			<div class=userImg>
			            		<img src="../resources/img/userCircle.png" alt="userCircle" style="width: 45px;">
	            			</div>
	            			<div class="flex-1">
			            		<form action="replyWrite.board" method="post">
			            			<input type="hidden" name="boardId" value="${comment.boardId}">
		    						<input type="hidden" name="postNo" value="${comment.postNo}">
		    						<input type="hidden" name="parentId" value="${comment.commentNo}">
			            			<textarea placeholder="댓글을 입력하세요"  name="commentContent"></textarea>
			            			<div class="flex justify-end reply-submit-cancel-btn">
				            			<button type="submit" class="reply-submit-btn"><span class="material-symbols-outlined" style="font-size:18px;"> edit</span></button>
			            				<button class=reply-cancel-btn>취소</button>
			            			</div>
			            		</form>
	            			</div>
	            		</div>
            		</div>
            	</div>
			</c:forEach>
        </div>
    </div>
</div>

<script>
$(document).ready(function() {
    $('.reply-write-btn').on('click', function() {
    	if ( $(this).next('.reply-write').hasClass('hidden')){
    		$(this).text('댓글 취소');
    	}else{
    		$(this).text('댓글 달기');
    	}
        $(this).next('.reply-write').toggleClass('hidden');
    });
});
</script>

<%@ include file="../include/footer.jsp" %>
