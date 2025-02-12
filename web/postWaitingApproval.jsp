<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<c:set var="pendingPostContent" value="${requestScope.CONTENT_PENDING_POST}"/>
<c:set var="loginStatus" value="${sessionScope.LOGIN}"/>
<c:set var="currentUser" value="${sessionScope.CURRENT_USER}"/>
<c:if test="${empty currentUser}">
    <c:redirect url="notFoundPage" />
</c:if>
<c:if test="${currentUser.role != 'M'}">
    <c:redirect url="notFoundPage" />
</c:if>
<!DOCTYPE html>
<html lang="en">
    <head>
        <meta charset="UTF-8" />
        <meta http-equiv="X-UA-Compatible" content="IE=edge" />
        <meta name="viewport" content="width=device-width, initial-scale=1.0" />
        <title>Posts waiting for approval | FPT Blog</title>
        <link rel="preconnect" href="https://fonts.googleapis.com" />
        <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin />
        <link
            href="https://fonts.googleapis.com/css2?family=Roboto:ital,wght@0,100;0,300;0,400;0,500;0,700;0,900;1,100;1,300;1,400;1,500;1,700;1,900&display=swap"
            rel="stylesheet"
            />
        <script
            src="https://kit.fontawesome.com/1b1fb57155.js"
            crossorigin="anonymous"
        ></script>
        <script src="https://unpkg.com/sweetalert/dist/sweetalert.min.js"></script>
        <link rel="stylesheet" href="./styles/postWaitingApprovalStyle.css" />
    </head>
    <body>
        <!-- header  -->
        <!-- header  -->
        <!-- header  -->
        <header >
            <div class="container_header">
                <div class="container_left">
                    <div class="toggle_sidebar" onclick="toggleSidebarPhone()">
                        <img src="./images/toggle_sidebar_icon.svg" />
                    </div>
                    <div class="container_logo">
                        <a href="loadBlogs">
                            <img
                                src="https://i.chungta.vn/2017/12/22/LogoFPT-2017-copy-3042-1513928399.jpg"
                                />
                        </a>
                    </div>
                    <div class="dropdown_category">
                        <div class="container_category">
                            <p>Categories</p>
                        </div>
                        <div class="dropdown_category_content">
                            <c:forEach var="cateDTO" items="${sessionScope.CATEGORY_LIST}" >
                                <div class="dropdown_category_item">
                                    <c:url var="cateLink" value="searchByCategory">
                                        <c:param name="categoryId" value="${cateDTO.ID}"/>
                                    </c:url>
                                    <a href="${cateLink}">${cateDTO.name}</a>
                                </div>  
                            </c:forEach>
                        </div>
                    </div>
                    <div class="container_searchBar">
                        <input placeholder="Search..." />
                        <div class="container_icon" onclick="submit_form()">
                            <i class="fas fa-search"></i>
                        </div>
                    </div>
                </div>
                <!-- <div class="container_right">
                  <div class="container_button_register">
                    <button>
                      <a href="/login.html">Pending Posts </a>
                      <div class="num-post"><span>3</span></div>
                    </button>
                  </div>
                  <div>Avatar</div>
                </div> -->
                <div class="container_right">
                    <div class="container_button_register">
                        <button><a href="loadPendingPosts">Pending Post</a>
                        </button>
                    </div>
                    <div class="icon_notification_container">
                        <img src="./images/notification_icon.svg" />
                    </div>
                    <a href="messengerPage">
                        <div class="icon_notification_container">
                            <img src="./images/chat.svg" />
                        </div>
                    </a>
                    <div class="dropdown">
                        <div class="dropbtn">
                            <img
                                src="${currentUser.avatar}"
                                />
                        </div>
                        <div class="dropdown-content">
                            <div class="item-top">
                                <a
                                    ><h2>${currentUser.name}</h2>
                                    <p>@${currentUser.name}</p></a
                                >
                            </div>
                            <div style="padding: 0.5rem 0">
                                <div class="item">
                                    <a href="loadProfile?email=${currentUser.email}"><p>Profile</p></a>
                                </div>
                            </div>
                            <div class="item-bottom">
                                <a  href="logout">Sign Out</a>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </header>

        <!-- sidebar_phone -->
        <!-- sidebar_phone -->
        <!-- sidebar_phone -->
        <section class="sidebar_phone" id="sidebar_phone">
            <div class="container_sidebar_phone" id="container_sidebar_phone">
                <div class="container_toggle">
                    <h2 class="title">FPT Blog</h2>
                    <img
                        src="./images/close_button_icon.svg"
                        onclick="handleClickOutside()"
                        />
                </div>
                <div style="padding: 0.5rem">
                    <div class="introduce_community">
                        <h2 class="introduce_title">
                            <span class="brand_text">DEV Community</span> is a community of
                            690,628 amazing developers
                        </h2>
                        <p class="introduce_content">
                            We're a place where coders share, stay up-to-date and grow their
                            careers.
                        </p>
                        <div class="container_button">
                            <div class="container_button_register">
                                <button><a href="/login.html">Create account</a></button>
                            </div>
                            <div class="container_button_login">
                                <button><a href="/login.html">Log in</a></button>
                            </div>
                        </div>
                    </div>
                    <div class="sidebar_navigation">
                        <h2 class="title_navigation">Menu</h2>
                        <div class="container_item">
                            <img src="./images/house_icon.svg" />
                            <p>Home</p>
                        </div>
                        <div class="container_item">
                            <img src="./images/hand_shake_icon.svg" />
                            <p>Login</p>
                        </div>
                        <div class="container_item">
                            <img src="./images/hand_shake_icon.svg" />
                            <p>Pending Posts</p>
                            <div class="num-post"><span>3</span></div>
                        </div>
                    </div>
                    <div class="sidebar_navigation">
                        <h2 class="title_navigation">Common Tags</h2>
                        <div class="container_item">
                            <p>#nodejs</p>
                        </div>
                        <div class="container_item">
                            <p>#python</p>
                        </div>
                        <div class="container_item">
                            <p>#devops</p>
                        </div>
                        <div class="container_item">
                            <p>#angular</p>
                        </div>
                        <div class="container_item">
                            <p>#vuejs</p>
                        </div>
                    </div>
                </div>
            </div>
            <div
                class="outside_sidebar_phone"
                id="outside_sidebar_phone"
                onclick="handleClickOutside()"
                ></div>
        </section>

        <!-- container -->
        <!-- container -->
        <!-- container -->
        <div class="container">
            <div class="navigation_left">
                <div class="sidebar_navigation">
                    <h2 class="title_navigation">Menu</h2>
                    <a href="loadBlogs">
                        <div class="container_item">
                            <img src="./images/house_icon.svg" />
                            <p>Home</p>
                        </div>
                    </a>
                    <a href="loadPendingPosts">
                        <div class="container_item">
                            <img src="./images/list_icon.svg" />
                            <p>Pending Posts</p>
                        </div>
                    </a>
                    <a href="createPostPage">
                        <div class="container_item create-post">
                            <img src="./images/create-blog.svg" />
                            <p>Create Post</p>
                        </div>
                    </a>
                    <a href="loadDashboard?tab=post">
                        <div class="container_item create-post">
                            <img src="./images/dashborad.svg" />
                            <p>Give Award</p>
                        </div>
                    </a>
                </div>
            </div>
            <div class="container-item">  
                <div class="title">
                    <p class="title-text">${pendingPostContent.title}</p>
                    <div class="tag">
                        <c:forEach var="tag" items="${pendingPostContent.tag}">
                            <c:url var="searchByTagLink" value="searchByTag">
                                <c:param name="tag" value="${tag}" />
                            </c:url>
                            <a href="${searchByTagLink}">
                                <p><span class="hash"></span>#${tag}</p>
                            </a>
                        </c:forEach>
                    </div>
                    <div class="owner">
                        <div class="avt">
                            <img
                                class="avt-img"
                                src="${pendingPostContent.avatar}"
                                alt=""
                                />
                        </div>
                        <a href="loadProfile?email=${pendingPostContent.emailPost}">
                            <div class="name">${pendingPostContent.namePost}</div>
                        </a>
                        <div class="time">${pendingPostContent.createdDate}</div>
                    </div>
                </div>
                <div class="content-img-text">
                    <c:if test="${pendingPostContent.statusPost == 'WFU'}">
                        <c:set var="contentPending" value="${pendingPostContent.newContent}"/>
                    </c:if>
                    <c:if test="${pendingPostContent.statusPost != 'WFU'}">
                        <c:set var="contentPending" value="${pendingPostContent.postContent}"/>
                    </c:if>
                    <c:out value="${contentPending}" escapeXml="false"/>
                </div>
                <div>
                    <div class="label-request">
                        <c:if test="${pendingPostContent.statusPost == 'WFA'}">
                            <h3>Public Request</h3>
                        </c:if>
                        <c:if test="${pendingPostContent.statusPost == 'WFD'}">
                            <c:if test="${not empty pendingPostContent.note}">
                                <div class="del-reason">
                                    <h2>Reason of deleting:</h2>
                                    <p>${pendingPostContent.note}<p>
                                </div>
                            </c:if>
                            <h3>Delete Request</h3>
                        </c:if>
                        <c:if test="${pendingPostContent.statusPost == 'WFU'}">
                            <h3>Update Request</h3>
                        </c:if>
                    </div>
                    <c:if test="${pendingPostContent.statusPost != 'WFA'}">
                        <div class="decision_btn">
                            <form action="approvePost" method="POST">
                                <button type="submit"  class="approve-btn"
                                        >Approve</button>
                                <input type="hidden" name="postID" value="${pendingPostContent.ID}" />
                                <input type="hidden" name="emailMentor" value="${currentUser.email}" />
                                <input type="hidden" name="statusPost" value="${pendingPostContent.statusPost}" />
                                <input type="hidden" name="mentorDecision" value="approve"/>
                            </form>

                            <form action="approvePost" method="POST">
                                <button type="submit" class="reject-btn">Reject</button>
                                <input type="hidden" name="postID" value="${pendingPostContent.ID}" />
                                <input type="hidden" name="emailMentor" value="${currentUser.email}" />
                                <input type="hidden" name="statusPost" value="${pendingPostContent.statusPost}" />
                                <input type="hidden" name="mentorDecision" value="reject"/>
                            </form>
                        </div>
                    </c:if>
                    <c:if test="${pendingPostContent.statusPost == 'WFA'}">
                        <div class="decision_btn">
                            <form action="approvePost" method="POST">
                                <button type="submit"  class="approve-btn"
                                        >Approve</button>
                                <input type="hidden" name="postID" value="${pendingPostContent.ID}" />
                                <input type="hidden" name="emailMentor" value="${currentUser.email}" />
                                <input type="hidden" name="statusPost" value="${pendingPostContent.statusPost}" />
                                <input type="hidden" name="mentorDecision" value="approve"/>
                            </form>

                            <form action="approvePost" method="POST" id="rejectWFA">
                                <input type="hidden" name="postID" value="${pendingPostContent.ID}" />
                                <input type="hidden" name="emailMentor" value="${currentUser.email}" />
                                <input type="hidden" name="statusPost" value="${pendingPostContent.statusPost}" />
                                <input type="hidden" name="mentorDecision" value="reject"/>
                                <input type="hidden" name="reason" value="" id="reason-value"/>
                            </form>
                            <button class="reject-btn reject-btn-WFA">Reject</button>
                        </div>
                    </c:if>
                </div>
            </div>
        </div>
    </div>

    <!-- modal -->
    <!-- modal -->
    <!-- modal -->
    <div class="reason-modal hidden">
        <h1>Please input the reason why you reject this post</h1>

        <textarea id="reason-textarea" cols="30" rows="10" placeholder="Input your reason here">
        </textarea>

        <div class="btn-gr">
            <button class="submit-btn">Submit</button>
            <button class="cancel-btn">Cancel</button>
        </div>


    </div>
    <div class="overlay hidden"></div>

    <!-- footer -->
    <!-- footer -->
    <!-- footer -->
    <footer>
        <div class="container_footer">

            <div class="cmp-text">
                <p class="text_footer">
                    <span class="text_footer_strong">
                        <a href="https://legal.web.com" />Legal</a>
                    </span>
                    &nbsp;&nbsp;|&nbsp;&nbsp;
                    <span class="text_footer_strong">
                        <a href="https://www.fpt-software.com/privacy-statement/" />Privacy Policy</a>
                    </span>
                    &nbsp;&nbsp;|&nbsp;&nbsp;
                    <span class="text_footer_strong">
                        <a href="https://www.fpt-software.com/terms-of-use/" />Terms of Use</a>
                    </span>
                    &nbsp;&nbsp;|&nbsp;&nbsp;
                    <span class="text_footer_strong">
                        <a href="https://www.fpt-software.com/contact-us/" />Contact Us</a>
                    </span>
                    &nbsp;&nbsp;|&nbsp;&nbsp;
                    <span class="text_footer_strong">
                        <a href="https://blog.fpt-software.com" />Technology Blog</a>
                    </span>
                </p>
            </div>
    </div>
    <div style="margin: 0.25rem 0"></div>
    <div>
        <div class="cmp-text">
            <p class="text_footer">
            <div class="text_footer_container">
                    © Copyright 2021 FPT University. All rights reserved. &nbsp;
                    <br>
                    All registered trademarks herein are the property of their respective owners.
                <img src="./images/fpt-university.png" />
            </div>
            </p>
        </div>
    </div>
    </footer>
    <!-- script   -->
    <!-- script   -->
    <!-- script   -->
    <script>
        const rejectWFABtn = document.querySelector(".reject-btn-WFA");
        const overlay = document.querySelector(".overlay");
        const reasonModal = document.querySelector(".reason-modal")
        const cancelBtn = document.querySelector(".cancel-btn");
        const reasonTextArea = document.querySelector("#reason-textarea");
        const submitBtn = document.querySelector(".submit-btn");
        const reasonHiddenForm = document.querySelector("#reason-value");
        const reasonForm = document.querySelector("#rejectWFA")


        // reasonForm.addEventListener("submit",(e)=>{
        //     if(reasonHiddenForm.value === ""){
        //         e.preventDefault();
        //         swal({
        //             title: "Reason is blank",
        //             text: "You have to input the reason",
        //             icon: "Error",
        //             button: "Ok",
        //             });
        //         return;
        //     }
        // })

        overlay.addEventListener("click", () => {
            reasonModal.classList.toggle("hidden");
            overlay.classList.toggle("hidden");
        })

        rejectWFABtn.addEventListener("click", () => {
            reasonModal.classList.toggle("hidden");
            overlay.classList.toggle("hidden");
            reasonTextArea.focus();

        })

        cancelBtn.addEventListener("click", () => {
            reasonModal.classList.toggle("hidden");
            overlay.classList.toggle("hidden");
        })

        submitBtn.addEventListener("click", () => {
            console.log(reasonTextArea.value);
            if (reasonTextArea.value.trim() === "") {
                swal({
                    title: "Reason is blank",
                    text: "You have to input the reason",
                    icon: "error",
                    button: "Ok",
                });
                return;
            } else {
                reasonHiddenForm.value = reasonTextArea.value;
                reasonForm.submit();
            }


        })
        // document.querySelector("#rejectWFA").addEventListener("submit",()=>{
        //     console.log('submit form: '+reasonTextArea.value); 

        //     document.querySelector("#rejectWFA").submit();
        // })


        function toggleSidebarPhone() {
            const toggle_sidebar = document.getElementById("sidebar_phone");
            toggle_sidebar.style.display = "block";
        }
        function handleClickOutside() {
            const toggle_sidebar = document.getElementById("sidebar_phone");
            toggle_sidebar.style.display = "none";
        }
        function submit_form()
        {
            var form = document.getElementById("searchit");
            form.submit();
        }
    </script>
</body>
</html>
