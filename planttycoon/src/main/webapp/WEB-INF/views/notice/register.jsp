<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="../include/header.jsp" %>
<script src="${ctx}/resources/ckeditor/ckeditor.js"></script>
<script src="${ctx}/resources/ckeditor/translations/ko.js"></script>
<link rel="stylesheet" href="${ctx}/resources/css/write.css">
		<!-- 사이드 메뉴 -->  
            <div class="side">
                <ul class="gnb">
                    <li> <!--메뉴 선택 시 on클래스 붙음-->
                        <a href="${ctx}/home" class="menu1 nolnb">홈</a> <!--2뎁스 메뉴 없을 때 nolnb클래스 붙음-->
                    </li>
                    <li>
                        <a href="javascript:void(0);" class="menu2">식물현황</a>
                        <ul class="lnb">
                            <li> <!--메뉴 선택 시 on클래스 붙음-->
                                <a href="${ctx}/plant/monitoring">실시간 모니터링</a>
                            </li>
                            <li> <!--메뉴 선택 시 on클래스 붙음-->
                                <a href="${ctx}/plant/status">온도/습도/조도</a>
                            </li>
                            <li> <!--메뉴 선택 시 on클래스 붙음-->
                                <a href="${ctx}/plant/watering">급수관리</a>
                            </li>
                        </ul>
                    </li>
                    <li> <!--메뉴 선택 시 on클래스 붙음-->
                        <a href="${ctx}/journal/list" class="menu3 nolnb">관찰일지</a>
                    </li>
                    <li class="on"> <!--메뉴 선택 시 on클래스 붙음-->
                        <a href="${ctx}/notice/list" class="menu4 nolnb">공지사항</a>
                    </li>
                    <sec:authorize access="hasRole('ROLE_ADMIN')">
	                    <li> <!--메뉴 선택 시 on클래스 붙음-->
	                        <a href="${ctx}/management" class="menu5 nolnb">회원관리</a>
	                    </li>
                    </sec:authorize>
                </ul>
            </div>
            <div class="container">
                <div class="container_inner">

                    <div class="sub_title">
                        <h3>공지사항</h3>
                        <button type="button" onclick="location.href='${ctx}/notice/list'">
			                <span><img src="${ctx}/resources/images/ic_backlist.png" alt="목록으로 돌아가기 아이콘"></span>
			                목록으로 돌아가기
			            </button>
                    </div>
                    <div class="write_form">
                        <form id="noticeForm" action="${ctx}/notice/register" method="post">
                        	<sec:csrfInput/>
				           				
				            <div class="write_box">
				                <p>제목</p>
				                <input type="text" id="noticeTitle" name="noticeTitle" placeholder="제목을 입력하세요" class="form-control" required>
				            </div>
				
				            <div class="write_box">
				                <p>내용</p>
				                <textarea id="editor" name="noticeContent"></textarea> <%-- name 속성 추가 --%>
				            </div>
				
				            <div class="write_btn_wrap">
				                <button type="button" class="btn_white" onclick="location.href='${ctx}/notice/list'">취소</button>
				                <button type="submit" id="saveButton" class="btn_green">등록</button>
				            </div>
				        </form>
                    </div>

                </div>
            </div>
        </div>
    </div>
    <script>
//     ClassicEditor
//     .create(document.querySelector('#editor'), {
//     	 ckfinder: {
//              uploadUrl: '${ctx}/upload/image',
//              withCredentials: true, // CSRF 토큰을 쿠키로 전송하도록 설정
//              headers: {
//             	  '${_csrf.headerName}': document.querySelector('meta[name="_csrf"]').getAttribute('content') // CSRF 토큰 헤더 추가
//                 /*  'X-CSRF-TOKEN': document.querySelector('meta[name="_csrf"]').getAttribute('content') // CSRF 토큰 헤더 추가 */
//              }
//          }
//      })
//     .catch(error => {
//         console.error(error);
//     });
    </script>
<script>
 // CSRF 토큰 추출 함수
    function getCsrfToken() {
        const token = document.querySelector('meta[name="_csrf"]').getAttribute('content');
        const header = document.querySelector('meta[name="_csrf_header"]').getAttribute('content');
        return { token, header };
    }

    // CKEditor5 생성
    let editor;
    ClassicEditor
        .create(document.querySelector('#editor'), {
        	// 여기 툴바 부분의 옵션명을 넣어주면 원하는 설정을 할수 있습니다. 
    		toolbar: [ 'undo', 'redo', '|', 'bold', 'italic', '|', 'link', 'imageUpload', 'mediaEmbed', '|', 'bulletedList', 'numberedList', 'blockQuote'], 
    		//---------------------------------------------------------------- 
    		language: 'ko',
    		image: {
    			resizeUnit: 'px',
    			toolbar: [
    				'imageTextAlternative',
    				'imageStyle:alignLeft',
    				'imageStyle:full',
    				'imageStyle:side'
    			],
    			styles: [ 'full','alignLeft','alignRight','side' ]
    		},
    		table: {
    			contentToolbar: [
    				'tableColumn',
    				'tableRow',
    				'mergeTableCells'
    			]
    		},
            language: 'ko',
            mediaEmbed: {
                previewsInData: true
            },
            ckfinder: {
                uploadUrl: '/ajax/image'
            }
        })
        .then(newEditor => {
            editor = newEditor;

            editor.plugins.get('FileRepository').createUploadAdapter = loader => {
                return new UploadAdapter(loader);
            };
        })
        .catch(error => {
            console.error('CKEditor5 초기화 중 오류 발생:', error);
        });

    // 이미지 업로드 어댑터 클래스
    class UploadAdapter {
        constructor(loader) {
            this.loader = loader;
        }

        upload() {
            return this.loader.file
                .then(file => {
                    const formData = new FormData();
                    formData.append('upload', file);

                    // CSRF 토큰 가져오기
                    const csrf = getCsrfToken();

                    return fetch('/ajax/image', {
                        method: 'POST',
                        headers: {
                            [csrf.header]: csrf.token // 헤더에 CSRF 토큰 추가
                        },
                        body: formData
                    });
                })
                .then(response => {
                    if (!response.ok) {
                        throw new Error('이미지 업로드 실패');
                    }
                    return response.json(); // JSON 형식으로 응답 파싱
                })
                .then(result => {
                    if (result && result.url) {
                        return { default: result.url };
                    } else {
                        throw new Error('이미지 업로드에 실패했습니다.');
                    }
                })
                .catch(error => {
                    console.error('이미지 업로드 오류:', error);
                    throw error;
                });
        }
    }

    document.getElementById('saveButton').addEventListener('click', function (event) {
        event.preventDefault(); // 기본 폼 제출을 막습니다.
        const title = document.getElementById('noticeTitle').value;
        const editorContent = editor.getData();

        if (!title.trim()) {
            alert('제목을 입력하세요.');
            return;
        }

        if (!editorContent.trim()) {
            alert('내용을 입력하세요.');
            return;
        }

        // 제목과 내용이 모두 입력된 경우 폼을 제출합니다.
        document.getElementById('noticeForm').submit();
    });
</script>
    
</body>
</html>