<%@page contentType="text/html" pageEncoding="UTF-8"%> <%@taglib
    uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
    <!DOCTYPE html>
    <html lang="en">
        <head>
            <meta charset="UTF-8" />
            <meta http-equiv="X-UA-Compatible" content="IE=edge" />
            <meta name="viewport" content="width=device-width, initial-scale=1.0" />
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
            <link rel="stylesheet" href="./styles/searchResult.css" />
            <title>Search Result | FPT Blog</title>
        </head>
        <body>
            <c:set var="loginStatus" value="${sessionScope.LOGIN}" />
            <c:set var="currentUser" value="${sessionScope.CURRENT_USER}" />
            <!-- header  -->
            <!-- header  -->
            <!-- header  -->
            <header>
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
                                <c:forEach var="cateDTO" items="${sessionScope.CATEGORY_LIST}">
                                    <div class="dropdown_category_item">
                                        <c:url var="cateLink" value="searchByCategory">
                                            <c:param name="categoryId" value="${cateDTO.ID}" />
                                        </c:url>
                                        <a href="${cateLink}">${cateDTO.name}</a>
                                    </div>
                                </c:forEach>
                            </div>
                        </div>
                        <div class="container_searchBar">
                            <form id="searchit" action="searchTitle">
                                <input
                                    placeholder="Search..."
                                    name="titleValue"
                                    value="${param.titleValue}"
                                    autocomplete="off"
                                    />
                                <div class="container_icon" onclick="submit_form()">
                                    <i class="fas fa-search"></i>
                                </div>
                            </form>
                        </div>
                    </div>
                    <!-- <div class="container_right">
                                        <div class="container_button_login">
                                          <button><a href="/login.html">ÄÄng nháº­p</a></button>
                                        </div>
                                        <div class="container_button_register">
                                          <button><a href="/login.html">Táº¡o tÃ i khoáº£n</a></button>
                                        </div>
                                      </div> -->
                    <c:if test="${loginStatus == 'logined'}">
                        <div class="container_right">
                            <c:if test="${currentUser.role == 'S'}">
                                <div class="container_button_register">
                                    <a href="createPostPage"><button>Create Post</button></a>
                                </div>
                            </c:if>
                            <c:if test="${currentUser.role == 'M'}">
                                <div class="container_button_register">
                                    <a href="loadPendingPosts?postStatus=WFA"><button>Pending Post</button></a>
                                </div>
                            </c:if>
                            <c:if test="${currentUser.role == 'A'}">
                                <div class="container_button_register">
                                    <a href="createCategoryPage"
                                       ><button>Create Category</button></a
                                    >
                                </div>
                            </c:if>
                            <div class="dropdown">
                                <div class="dropbtn_noti">
                                    <img src="./images/notification_icon.svg" />
                                    <div id="warning" class="warning warning-hidden">!</div>
                                </div>
                                <div class="dropdown-content1">
                                </div>
                            </div>
                            <a href="messengerPage">
                                <div class="icon_notification_container">
                                    <img src="./images/chat.svg" />
                                </div>
                            </a>

                            <div class="dropdown">
                                <div class="dropbtn">
                                    <img src="${currentUser.avatar}" />
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
                                            <c:url var="loadCurrentProfileLink" value="loadProfile">
                                                <c:param name="email" value="${currentUser.email}" />
                                            </c:url>
                                            <a href="${loadCurrentProfileLink}"><p>Profile</p></a>
                                        </div>
                                    </div>
                                    <div class="item-bottom">
                                        <a href="logout">Sign Out</a>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </c:if>
                    <c:if test="${loginStatus != 'logined'}">
                        <div class="container_right">
                            <div class="container_button_login">
                                <button><a href="firstLoginPage">Login</a></button>
                            </div>
                            <div class="container_button_register">
                                <button><a href="registerPage">Create account</a></button>
                            </div>
                        </div>
                    </c:if>
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
                                    <button><a href="/login.html">Táº¡o tÃ i khoáº£n</a></button>
                                </div>
                                <div class="container_button_login">
                                    <button><a href="/login.html">ÄÄng nháº­p</a></button>
                                </div>
                            </div>
                        </div>
                        <div class="sidebar_navigation">
                            <h2 class="title_navigation">Menu</h2>
                            <div class="container_item">
                                <img src="./images/house_icon.svg" />
                                <p>Trang chá»§</p>
                            </div>
                            <div class="container_item">
                                <img src="./images/hand_shake_icon.svg" />
                                <p>ÄÄng nháº­p</p>
                            </div>
                        </div>
                        <div class="sidebar_navigation">
                            <h2 class="title_navigation">Tags phá» biáº¿n</h2>
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
                <div class="left-menu">
                    <div class="navigation_left">
                        <div class="sidebar_navigation">
                            <h2 class="title_navigation">Menu</h2>
                            <a href="loadBlogs">
                                <div class="container_item">
                                    <img src="./images/house_icon.svg" />
                                    <p>Home</p>
                                </div>
                            </a>
                            <c:if test="${loginStatus == 'logined'}">
                                <c:if test="${currentUser.role == 'S'}">
                                    <a href="createPostPage">
                                        <div class="container_item create-post">
                                            <img src="./images/create-blog.svg" />
                                            <p>Create Post</p>
                                        </div>
                                    </a>
                                    <a href="loadPostManagement">
                                        <div class="container_item create-post">
                                            <img src="./images/post-management.png" />
                                            <p>Post Management</p>
                                        </div>
                                    </a>
                                </c:if>
                                <c:if test="${currentUser.role == 'M'}">
                                    <a href="loadPendingPosts?postStatus=WFA">
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

                                </c:if>
                                <c:if test="${currentUser.role == 'A'}">
                                    <a href="createCategoryPage">
                                        <div class="container_item">
                                            <img src="./images/category_icon.svg" />
                                            <p>Create Category</p>
                                        </div>
                                    </a>
                                    <a href="loadUserList">
                                        <div class="container_item user-list-icon">
                                            <img src="./images/user-list.svg" />
                                            <p>User List</p>
                                        </div>
                                    </a>
                                    <a href="loadAllComments">
                                        <div class="container_item user-list-icon">
                                            <img src="./images/comment.png" />
                                            <p>Comments Management</p>
                                        </div>
                                    </a>
                                    <a href="loadAwardStandard">
                                        <div class="container_item user-list-icon">
                                            <img src="./images/adjust_icon.png" />
                                            <p>Award Adjustment</p>
                                        </div>
                                    </a>
                                </c:if>
                            </c:if>
                            <!--                        <a href="createCategoryPage">
                                            <div class="container_item">
                                                <img src="./images/category_icon.svg" />
                                                <p>Create Category</p>
                                            </div>
                                        </a>
                                        <a href="">
                                            <div class="container_item">
                                                <img src="./images/list_icon.svg" />
                                                <p>User List</p>
                                            </div>
                                        </a>-->
                        </div>
                    </div>
                </div>
                <div class="container-item">
                    <h1 class="search-result-title">Search Result</h1>
                    <div class="container_posts">
                        <c:set
                            var="searchTitleList"
                            value="${requestScope.SEARCHLIST_TITLE}"
                            />
                        <c:if test="${not empty searchTitleList}">
                            <c:forEach var="searchTitleDTO" items="${searchTitleList}">
                                <div class="post">
                                    <a href="/contentPage.html">
                                        <div class="container_info_post">
                                            <div class="user_info">
                                                <div class="container_avatar">
                                                    <img
                                                        src="${searchTitleDTO.avatar}"
                                                        />
                                                </div>
                                                <div class="container_name_date_post">
                                                    <c:url var="loadProfileLink" value="loadProfile">
                                                        <c:param
                                                            name="email"
                                                            value="${searchTitleDTO.emailPost}"
                                                            />
                                                    </c:url>
                                                    <a href="${loadProfileLink}">
                                                        <p class="username">${searchTitleDTO.namePost}</p>
                                                    </a>
                                                    <p class="date_posted">
                                                        ${searchTitleDTO.approvedDate}
                                                    </p>
                                                </div>
                                            </div>
                                            <div class="post_info">
                                                <c:url var="loadContentLink" value="loadPostContent">
                                                    <c:param name="postId" value="${searchTitleDTO.ID}" />
                                                </c:url>
                                                <a href="${loadContentLink}">
                                                    <h1 class="title_post">${searchTitleDTO.title}</h1>
                                                </a>
                                                <div class="hashtag">
                                                    <c:forEach var="tag" items="${searchTitleDTO.tag}">
                                                        <c:url var="searchByTagLink" value="searchByTag">
                                                            <c:param name="tag" value="${tag}"/>
                                                        </c:url>
                                                        <a href="${searchByTagLink}">
                                                            <p><span class="hash"></span>#${tag}</p>
                                                        </a>
                                                    </c:forEach>
                                                </div>
                                                <div class="statistic">
                                                    <div class="reaction_and_comments">
                                                        <div>
                                                            <img src="./images/vote_icon.svg" />
                                                            <p>
                                                                ${searchTitleDTO.likes}
                                                                <span class="text_comments_votes">Likes</span>
                                                            </p>
                                                        </div>
                                                        <div>
                                                            <img src="./images/comment_icon.svg" />
                                                            <p>
                                                                ${searchTitleDTO.comments}
                                                                <span class="text_comments_votes">Comments</span>
                                                            </p>
                                                        </div>
                                                        <div>
                                                            <img src="./images/view-icon.png" />
                                                            <p>
                                                                ${blogDTO.views}
                                                                <span class="text_comments_votes">Views</span>
                                                            </p>
                                                        </div>        
                                                    </div>
                                                    <div class="time_and_save">
                                                    </div>
                                                </div>
                                            </div>
                                        </div>
                                    </a>
                                </div>
                            </c:forEach>
                        </c:if>

                        <c:set
                            var="searchCategoryList"
                            value="${requestScope.SEARCHLIST_CATEGORY}"
                            />
                        <c:if test="${not empty searchCategoryList}">
                            <c:forEach var="searchCategoryDTO" items="${searchCategoryList}">
                                <div class="post">
                                    <a href="/contentPage.html">
                                        <div class="container_info_post">
                                            <div class="user_info">
                                                <div class="container_avatar">
                                                    <img src="${searchCategoryDTO.avatar}" />
                                                </div>
                                                <div class="container_name_date_post">
                                                    <c:url var="loadProfileLink" value="loadProfile">
                                                        <c:param
                                                            name="email"
                                                            value="${searchCategoryDTO.emailPost}"
                                                            />
                                                    </c:url>
                                                    <a href="${loadProfileLink}">
                                                        <p class="username">${searchCategoryDTO.namePost}</p>
                                                    </a>
                                                    <p class="date_posted">
                                                        ${searchCategoryDTO.approvedDate}
                                                    </p>
                                                </div>
                                            </div>
                                            <div class="post_info">
                                                <c:url var="loadContentLink" value="loadPostContent">
                                                    <c:param
                                                        name="postId"
                                                        value="${searchCategoryDTO.ID}"
                                                        />
                                                </c:url>
                                                <a href="${loadContentLink}">
                                                    <h1 class="title_post">${searchCategoryDTO.title}</h1>
                                                </a>
                                                <div class="hashtag">
                                                    <c:forEach var="tag" items="${searchCategoryDTO.tag}">
                                                        <c:url var="searchByTagLink" value="searchByTag">
                                                            <c:param name="tag" value="${tag}"/>
                                                        </c:url>
                                                        <a href="${searchByTagLink}">
                                                            <p>
                                                                <span class="hash"></span>#${tag}
                                                            </p>
                                                        </a>
                                                    </c:forEach>
                                                </div>
                                                <div class="statistic">
                                                    <div class="reaction_and_comments">
                                                        <div>
                                                            <img src="./images/vote_icon.svg" />
                                                            <p>
                                                                ${searchCategoryDTO.likes}
                                                                <span class="text_comments_votes">Likes</span>
                                                            </p>
                                                        </div>
                                                        <div>
                                                            <img src="./images/comment_icon.svg" />
                                                            <p>
                                                                ${searchCategoryDTO.comments}
                                                                <span class="text_comments_votes">Comments</span>
                                                            </p>
                                                        </div>

                                                    </div>
                                                    <div class="time_and_save">
                                                        <div>
                                                            <button>Save</button>
                                                        </div>
                                                    </div>
                                                </div>
                                            </div>
                                        </div>
                                    </a>
                                </div>
                            </c:forEach>
                        </c:if>

                        <c:set var="searchTagList" value="${requestScope.SEARCHLIST_TAG}"/>
                        <c:if test="${not empty searchTagList}">
                            <c:forEach var="searchTagDTO" items="${searchTagList}">
                                <div class="post">
                                    <a href="/contentPage.html">
                                        <div class="container_info_post">
                                            <div class="user_info">
                                                <div class="container_avatar">
                                                    <img src="${searchTagDTO.avatar}" />
                                                </div>
                                                <div class="container_name_date_post">
                                                    <c:url var="loadProfileLink" value="loadProfile">
                                                        <c:param
                                                            name="email"
                                                            value="${searchTagDTO.emailPost}"
                                                            />
                                                    </c:url>
                                                    <a href="${loadProfileLink}">
                                                        <p class="username">${searchTagDTO.namePost}</p>
                                                    </a>
                                                    <p class="date_posted">
                                                        ${searchTagDTO.approvedDate}
                                                    </p>
                                                </div>
                                            </div>
                                            <div class="post_info">
                                                <c:url var="loadContentLink" value="loadPostContent">
                                                    <c:param
                                                        name="postId"
                                                        value="${searchTagDTO.ID}"
                                                        />
                                                </c:url>
                                                <a href="${loadContentLink}">
                                                    <h1 class="title_post">${searchTagDTO.title}</h1>
                                                </a>
                                                <div class="hashtag">
                                                    <c:forEach var="tag" items="${searchTagDTO.tag}">
                                                        <c:url var="searchByTagLink" value="searchByTag">
                                                            <c:param name="tag" value="${tag}"/>
                                                        </c:url>
                                                        <a href="${searchByTagLink}">
                                                            <p>
                                                                <span class="hash"></span>#${tag}
                                                            </p>
                                                        </a>
                                                    </c:forEach>
                                                </div>
                                                <div class="statistic">
                                                    <div class="reaction_and_comments">
                                                        <div>
                                                            <img src="./images/vote_icon.svg" />
                                                            <p>
                                                                ${searchTagDTO.likes}
                                                                <span class="text_comments_votes">Likes</span>
                                                            </p>
                                                        </div>
                                                        <div>
                                                            <img src="./images/comment_icon.svg" />
                                                            <p>
                                                                ${searchTagDTO.comments}
                                                                <span class="text_comments_votes">Comments</span>
                                                            </p>
                                                        </div>

                                                    </div>
                                                    <div class="time_and_save">
                                                        <div>
                                                            <button>Save</button>
                                                        </div>
                                                    </div>
                                                </div>
                                            </div>
                                        </div>
                                    </a>
                                </div>
                            </c:forEach>
                        </c:if>


                        <c:if test="${empty searchTitleList && empty searchCategoryList && empty searchTagList}">
                            <div class="no-result">
                                <h1>No result matches</h1>
                            </div>
                        </c:if>
                    </div>
                </div>
            </div>

            <!-- Footer -->

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
                function toggleSidebarPhone() {
                    const toggle_sidebar = document.getElementById("sidebar_phone");
                    toggle_sidebar.style.display = "block";
                }
                function handleClickOutside() {
                    const toggle_sidebar = document.getElementById("sidebar_phone");
                    toggle_sidebar.style.display = "none";
                }
                function submit_form() {
                    var form = document.getElementById("searchit");
                    form.submit();
                }
            </script>
            <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
            <script src="https://www.gstatic.com/firebasejs/8.10.0/firebase-app.js"></script>
            <script src="https://www.gstatic.com/firebasejs/8.10.0/firebase-firestore.js"></script>
            <script>
                // Initialize Firebase
                firebase.initializeApp({
                    apiKey: 'AIzaSyAPgZZxNDsNeVB-C6hMGKzsFelsBRIjdBI',
                    authDomain: 'udemy-vue-firebase-si.firebaseapp.com',
                    projectId: 'udemy-vue-firebase-si',
                });
                const db = eval('firebase.firestore()');
                const notiWrapper = document.querySelector(".dropdown-content1");
                let lastestNotiCreatedAt = "";
                let componentRunOnDepend = false;
                let lol = false;
                let currentUser = `${currentUser.email}`;
                currentUser = currentUser.substr(0, currentUser.indexOf("@"));
                const itemNoti = (avatar, user, action, postID, createdAt) => {
                    return (
                            ` <a href="loadPostContent?postId=\${postID}">
                                <div class="noti_item">
                                    <img class="noti_other_user"  src="\${avatar}"/>
                                      <div>
                                         <p><b>\${user}</b> \${action} your post</p>
                                        <p style="font-size: 14px; margin-top: 0.2rem">\${createdAt}</p>
                                      </div>
                                </div>
                            </a>`
                            )
                }

                const itemNotiNew = (avatar, user, action, postID, createdAt) => {
                    return (
                            ` <a href="loadPostContent?postId=\${postID}">
                                <div class="noti_item_new">
                                    <img class="noti_other_user"  src="\${avatar}"/>
                                      <div>
                                        <p><b>\${user}</b> \${action} your post</p>
                                        <p style="font-size: 14px; margin-top: 0.2rem">\${createdAt}</p>
                                      </div>
                                </div>
                            </a>`
                            )
                }

                $(".dropbtn_noti").hover(function (e) {
                    $("#warning").addClass("warning-hidden");
                });
                // Functions
                const componentDidMount = (function () {
                    let ref = false;
                    return function () {
                        if (!ref) {
                            ref = true;
                            componentRunOnDepend = true;
                            getDocumentOnMount();
                        }
                    };
                })();

                // useEffect
                componentDidMount();

                async function getDocumentOnMount() {
                    let domMessage = '';
                    let notifyRealtime = [];
                    await db
                            .collection('notify')
                            .doc(currentUser)
                            .collection("incoming")
                            .orderBy('createdAt', 'desc')
                            .limit(5)
                            .get()
                            .then((querySnapshot) => {
                                querySnapshot.forEach((doc) => {
                                    notifyRealtime.push(doc.data());
                                });
                            })
                            .catch((error) => {
                                console.log('Error getting documents: ', error);
                            });
                    if (notifyRealtime.length > 0) {
                        notifyRealtime.forEach((doc, index) => {
                            if (doc.createdAt) {
                                if (index === notifyRealtime.length - 1) {
                                    lastestNotiCreatedAt = doc.createdAt.seconds;
                                }
                                var date = new Date(doc.createdAt.toDate()).toLocaleString("en-GB", {year: 'numeric', month: 'numeric', day: 'numeric', hour: '2-digit', minute: '2-digit'});
                                domMessage += itemNoti(doc.avatar, doc.user, doc.action, doc.postId, date);

                            }
                        });
                    } else {
                        domMessage += `<div class="noti_item">
                                            <p></p>
                                        </div>
                                    </div>`;
                    }
                    notiWrapper.innerHTML = domMessage;
                }

                if (componentRunOnDepend) {
                    db.collection('notify')
                            .doc(currentUser)
                            .collection("incoming")
                            .orderBy('createdAt', 'desc')
                            .limit(1)
                            .onSnapshot((querySnapshot) => {
                                let domMessage = '';
                                let notifyRealtime = [];
                                querySnapshot.forEach((doc) => {
                                    if (doc.exists) {
                                        let id = doc.id;
                                        let data = {...doc.data(), id};
                                        notifyRealtime.push(data);
                                    }
                                });
                                notifyRealtime.forEach((doc, index) => {
                                    if (doc.createdAt) {
                                        console.log(lastestNotiCreatedAt, doc.createdAt.seconds);
                                        if (lol) {
                                            var date = new Date(doc.createdAt.toDate()).toLocaleString("en-GB", {year: 'numeric', month: 'numeric', day: 'numeric', hour: '2-digit', minute: '2-digit'});
                                            domMessage += itemNotiNew(doc.avatar, doc.user, doc.action, doc.postId, date);
                                        }
                                        lol = true;
                                    }
                                });
                                if (domMessage !== '') {
                                    notiWrapper.insertAdjacentHTML('afterbegin', domMessage);
                                    $("#warning").removeClass("warning-hidden");
                                }
                            });
                        }
            </script>
        </body>
    </html>
