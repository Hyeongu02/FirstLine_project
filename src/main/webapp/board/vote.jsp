<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<%@ include file="../include/header.jsp"%>
<div id="wrapped">
	<div class="top">
		<ul class="top_text">
			<li><a href="${pageContext.request.contextPath }/board/post_write_mini.jsp"><span class="glyphicon glyphicon-flag"></span>
					개설신청</a></li>
			<li><a href="${pageContext.request.contextPath }/board/mini.jsp"><span class="glyphicon glyphicon-list"></span> 
					전체 카테고리</a></li>
		</ul>
	</div>

	<div class="title">
		<h3 class="bold">${dto.boardType } 카테고리 신설 요청합니다</h3>
		<p>
			${dto.regdate } | 조회 ${dto.viewCount } | <span class="glyphicon glyphicon-thumbs-up"></span>${dto.likeCount }
		</p>
		<button type="button" class="title_right" onclick="location.href='increaseVoteLike.board?postNo=${dto.postNo}'">
			<span class="glyphicon glyphicon-thumbs-up">${dto.likeCount }</span>		
		</button>
		<button type="button" class="title_left" onclick="location.href='${pageContext.request.contextPath }/board/post_write_mini.jsp'">새 글(write)</button>
	</div>

	<div class="content">
		<div class="box">
			<p class="bold">투표 전 반드시 확인!</p>
			<p>1. 모든 신설 요청에 대해 1주일 내에 한 번만 투표 가능하므로 꼭 필요한 경우에만 작성해 주세요.</p>
			<p>2. 비회원은 투표에 참여하실 수 없습니다.</p>
		</div>
	</div>
	
    <form action="voteForm.board" method="post">
	    <input type="hidden" name="boardType" value="${dto.boardType}">
	    <input type="hidden" name="boardCategory" value="${dto.boardCategory}">
	    <input type="hidden" name="postNo" value="${dto.postNo}">
		<div class="container">
			<h4>${dto.boardType } 카테고리를 만드시는 걸 찬성하시겠습니까?</h4>
			<div class="grid">
				<button type="submit" name="voteOption" value="yes" class="option" id="yes" style="border: 1px solid #ccc;">
					<p class="text">찬성</p>
					<p class="percentage" id="percentageYes">%</p>
				</button>
				<button type="submit" name="voteOption" value="no" class="option" id="no" style="border: 1px solid #ccc;">
					<p class="text">반대</p>
					<p class="percentage" id="percentageNo">%</p>
				</button>
			</div>
		</div>
	</form>
</div>

<script>
        var yesVotes = 0;
        var noVotes = 0;

        document.addEventListener('DOMContentLoaded', function () {
            yesVotes = parseInt(localStorage.getItem('yesVotes')) || 0;
            noVotes = parseInt(localStorage.getItem('noVotes')) || 0;
            updatePercentages();
        });

        document.getElementById('yes').addEventListener('click', function() {
            submitVote('yes');
        });

        document.getElementById('no').addEventListener('click', function() {
            submitVote('no');
        });

        function submitVote(option) {
            if (option === 'yes') {
                yesVotes++;
            } else if (option === 'no') {
                noVotes++;
            }

            localStorage.setItem('yesVotes', yesVotes);
            localStorage.setItem('noVotes', noVotes);
            setCookie("voted", true, 7); // 7일 동안 쿠키 유지
            updatePercentages();

            // 실제 서버에 투표를 전송합니다.
            var form = document.getElementById('voteForm');
            form.elements['voteOption'].value = option;
            form.submit(); // 폼 제출
        }

        function updatePercentages() {
            var totalVotes = yesVotes + noVotes;
            var percentageYes = totalVotes === 0 ? 0 : (yesVotes / totalVotes) * 100;
            var percentageNo = totalVotes === 0 ? 0 : (noVotes / totalVotes) * 100;

            document.getElementById('percentageYes').innerText = Math.round(percentageYes) + '%';
            document.getElementById('percentageNo').innerText = Math.round(percentageNo) + '%';

            var yesOption = document.getElementById('yes');
            var noOption = document.getElementById('no');

            if (percentageYes > percentageNo) {
                yesOption.style.background = 'linear-gradient(to right, #00AFB9D5 ' + percentageYes + '%, #fff ' + percentageYes + '%)';
                noOption.style.background = 'linear-gradient(to right, #ddd ' + percentageNo + '%, #fff ' + percentageNo + '%)';
            } else {
                yesOption.style.background = 'linear-gradient(to right, #ddd ' + percentageYes + '%, #fff ' + percentageYes + '%)';
                noOption.style.background = 'linear-gradient(to right, #00AFB9D5 ' + percentageNo + '%, #fff ' + percentageNo + '%)';
            }
        }

        function setCookie(name, value, days) {
            const date = new Date();
            date.setTime(date.getTime() + (days * 24 * 60 * 60 * 1000)); // 현재 시간에 유효 기간을 더해서 만료 시간 설정
            const expires = "expires=" + date.toUTCString(); // 만료 시간을 UTC 형식의 문자열로 변환
            document.cookie = name + "=" + value + ";" + expires + ";path=/"; 
        }
    </script>
<%@ include file="../include/footer.jsp"%>