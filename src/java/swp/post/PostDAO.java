package swp.post;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import javax.naming.NamingException;
import swp.library.Style;
import swp.utils.DBHelper;

public class PostDAO {

    public ArrayList<PostDTO> getAllPostList() throws SQLException, ClassNotFoundException, NamingException {
        // tên, avt, email người đăng, title, id, số like, số cmt, approvedTime
        Connection conn = null;
        PreparedStatement stm = null;
        ResultSet rs = null;
        ArrayList<PostDTO> list = new ArrayList<>();
        try {
            conn = DBHelper.makeConnection();
            if (conn != null) {
                String sql = "select tag, title, postid, emailpost"
                        + ", Day(ApprovedDate) as ApprovedDay, month(ApprovedDate) as ApprovedMonth, year(ApprovedDate) as ApprovedYear"
                        + ", a.name, a.image, p.AwardID"
                        + " from tblPosts p left join tblAccounts a on emailpost = email where StatusPost = ? order by ApprovedDate desc";
                stm = conn.prepareStatement(sql);
                stm.setString(1, "A");

                rs = stm.executeQuery();
                while (rs.next()) {
                    String postID = rs.getString("PostID");
                    String emailPost = rs.getString("EmailPost");
                    String approvedDate = rs.getString("ApprovedDay") + "-" + rs.getString("ApprovedMonth") + "-"
                            + rs.getString("ApprovedYear");
                    String tag = rs.getString("Tag");
                    String title = rs.getString("Title");
                    String namePoster = rs.getString("Name");
                    String avatar = rs.getString("Image");
                    int like = getLikeCounting(postID);
                    int awardID = rs.getInt("AwardID");// bug 30%
                    int comments = getCommentCounting(postID);
                    PostDTO p = new PostDTO(postID, emailPost, Style.convertTagToArrayList(tag), title, approvedDate,
                            namePoster, avatar, awardID, like, comments);
                    list.add(p);
                }
            }
        } finally {
            if (rs != null) {
                rs.close();
            }
            if (stm != null) {
                stm.close();
            }
            if (conn != null) {
                conn.close();
            }

        }
        return list;
    }

    public int getCommentCounting(String postID) throws SQLException, ClassNotFoundException, NamingException {
        int count = 0;
        Connection conn = null;
        PreparedStatement stm = null;
        ResultSet rs = null;

        try {
            conn = DBHelper.makeConnection();
            if (conn != null) {
                String sql = "select count(id) as TOTAL from tblComments where postid = ?";
                stm = conn.prepareStatement(sql);
                stm.setString(1, postID);
                rs = stm.executeQuery();
                if (rs.next()) {
                    count = rs.getInt("TOTAL");
                }
            }
        } finally {
            if (rs != null) {
                rs.close();
            }
            if (stm != null) {
                stm.close();
            }
            if (conn != null) {
                conn.close();
            }

        }
        return count;
    }

    public int getLikeCounting(String postID) throws SQLException, ClassNotFoundException, NamingException {
        int count = 0;
        Connection conn = null;
        PreparedStatement stm = null;
        ResultSet rs = null;

        try {
            conn = DBHelper.makeConnection();
            if (conn != null) {
                String sql = "select count(id) as TOTAL from tbllikes where LikeStatus = 1 and postid = ? ";
                stm = conn.prepareStatement(sql);
                stm.setString(1, postID);
                rs = stm.executeQuery();
                if (rs.next()) {
                    count = rs.getInt("TOTAL");
                }
            }
        } finally {
            if (rs != null) {
                rs.close();
            }
            if (stm != null) {
                stm.close();
            }
            if (conn != null) {
                conn.close();
            }

        }
        return count;
    }

    public boolean insertANewPost(String email, String tag, String title, String content, int categoryID)
            throws SQLException, NamingException {
        Connection conn = null;
        PreparedStatement stm = null;
        ResultSet rs = null;
        boolean check = false;

        try {
            conn = DBHelper.makeConnection();
            if (conn != null) {
                String sql = "insert into tblPosts(PostID, EmailPost, EmailApprover, StatusPost, createdDate, Tag, Title, ApprovedDate, PostContent, CategoryID, AwardID) "
                        + "values(NEWID(), ?, null, ?, getdate(), ?, ?, null, ?, ?, null)";
                stm = conn.prepareStatement(sql);
                stm.setString(1, email);
                stm.setString(2, "WFA");
                stm.setString(3, tag);
                stm.setNString(4, title);
                stm.setNString(5, content);
                stm.setInt(6, categoryID);
                check = stm.executeUpdate() > 0;
            }
        } finally {
            if (rs != null) {
                rs.close();
            }
            if (stm != null) {
                stm.close();
            }
            if (conn != null) {
                conn.close();
            }
        }
        return check;
    }

    public ArrayList<PostDTO> getPostsByTitle(String title)
            throws SQLException, ClassNotFoundException, NamingException {
        ArrayList<PostDTO> list = new ArrayList<>();
        Connection conn = null;
        PreparedStatement stm = null;
        ResultSet rs = null;
        try {
            conn = DBHelper.makeConnection();
            if (conn != null) {
                // String sql = "select p.title, tag, postid, emailpost"
                // + ", Day(p.ApprovedDate) as ApprovedDay, month(p.ApprovedDate) as
                // ApprovedMonth, year(p.ApprovedDate) as ApprovedYear"
                // + ", a.name, a.image, p.AwardID"
                // + " from tblPosts p left join tblAccounts a on p.emailpost = a.email"
                // + " and title like ? and p.StatusPost = ? order by p.ApprovedDate desc";
                String sql = "select title, tag, postid, emailpost"
                        + ", Day(ApprovedDate) as ApprovedDay, month(ApprovedDate) as ApprovedMonth, year(ApprovedDate) as ApprovedYear"
                        + ", name, image, AwardID from tblPosts p, tblAccounts a where emailpost = email"
                        + " and title like ? and StatusPost = ? order by ApprovedDate desc";
                stm = conn.prepareStatement(sql);
                stm.setString(1, "%" + title + "%");
                stm.setString(2, "A");
                rs = stm.executeQuery();
                while (rs.next()) {
                    String postID = rs.getString("PostID");
                    String emailPost = rs.getString("EmailPost");
                    String approvedDate = rs.getString("ApprovedDay") + "-" + rs.getString("ApprovedMonth") + "-"
                            + rs.getString("ApprovedYear");
                    String tag = rs.getString("Tag");
                    String namePoster = rs.getString("Name");
                    String avatar = rs.getString("Image");
                    String titleColumn = rs.getString("Title");
                    int like = getLikeCounting(postID);
                    int awardID = rs.getInt("AwardID");
                    int comments = getCommentCounting(postID);
                    PostDTO p = new PostDTO(postID, emailPost, Style.convertTagToArrayList(tag), titleColumn,
                            approvedDate, namePoster, avatar, awardID, like, comments);
                    list.add(p);
                }
            }
        } finally {
            if (rs != null) {
                rs.close();
            }
            if (stm != null) {
                stm.close();
            }
            if (conn != null) {
                conn.close();
            }
        }
        return list;
    }

    public PostDTO getPostById(String id)
            throws SQLException, ClassNotFoundException, NamingException {
        Connection conn = null;
        PreparedStatement stm = null;
        ResultSet rs = null;
        PostDTO post = null;
        try {
            conn = DBHelper.makeConnection();
            if (conn != null) {
                String sql = "SELECT postID, title, tag, awardID, Day(ApprovedDate) as ApprovedDay, month(ApprovedDate) as ApprovedMonth, year(ApprovedDate) as ApprovedYear, PostContent, "
                        + "a.name, a.image, a.email "
                        + "FROM tblPosts p, tblAccounts a "
                        + "WHERE postID like ? AND a.email = EmailPost";
                stm = conn.prepareStatement(sql);
                stm.setString(1, id);
                rs = stm.executeQuery();
                if (rs.next()) {
                    String postID = rs.getString("postID");
                    String title = rs.getString("title");
                    String approvedDate = rs.getString("ApprovedDay") + "-" + rs.getString("ApprovedMonth") + "-"
                            + rs.getString("ApprovedYear");
                    String tags = rs.getString("tag");
                    String avatar = rs.getString("image");
                    String name = rs.getString("name");
                    String content = rs.getString("PostContent");
                    String email = rs.getString("email");
                    int like = getLikeCounting(id);
                    int awardID = rs.getInt("awardID");
                    int comments = getCommentCounting(id);
                    post = new PostDTO(postID, email, Style.convertTagToArrayList(tags), title, approvedDate, content, name, avatar, awardID, like, comments);
                }
            }
        } finally {
            if (rs != null) {
                rs.close();
            }
            if (stm != null) {
                stm.close();
            }
            if (conn != null) {
                conn.close();
            }
        }
        return post;
    }

    public ArrayList<PostDTO> getPostByCategory(String category)
            throws SQLException, ClassNotFoundException, NamingException {
        ArrayList<PostDTO> list = new ArrayList<>();
        Connection conn = null;
        PreparedStatement stm = null;
        ResultSet rs = null;
        try {
            conn = DBHelper.makeConnection();
            if (conn != null) {
                int cateID = Integer.parseInt(category); // database chỉ nhận int
                String sql = "SELECT title, tag, postid, emailpost, Day(ApprovedDate) AS ApprovedDay, "
                        + "month(ApprovedDate) AS ApprovedMonth, year(ApprovedDate) AS ApprovedYear, "
                        + "name, image, AwardID FROM tblPosts p, tblAccounts a "
                        + "WHERE emailpost = email AND CategoryID = ? AND StatusPost = 'A'"
                        + "ORDER BY ApprovedDate desc"; // sắp xếp ngày gần đây nhất
                stm = conn.prepareStatement(sql);
                stm.setInt(1, cateID);
                rs = stm.executeQuery();
                while (rs.next()) {
                    String postID = rs.getString("PostID");
                    String emailPost = rs.getString("EmailPost");
                    String approvedDate = rs.getString("ApprovedDay") + "-" + rs.getString("ApprovedMonth") + "-"
                            + rs.getString("ApprovedYear");
                    String tag = rs.getString("Tag");
                    String namePoster = rs.getString("Name");
                    String avatar = rs.getString("Image");
                    String titleColumn = rs.getString("Title");
                    int like = getLikeCounting(postID);
                    int awardID = rs.getInt("AwardID");
                    int comments = getCommentCounting(postID);
                    PostDTO p = new PostDTO(postID, emailPost, Style.convertTagToArrayList(tag), titleColumn,
                            approvedDate, namePoster, avatar, awardID, like, comments);
                    boolean check = list.add(p);
                    if (!check) {
                        throw new SQLException("getPostCategory bi ngu lz");
                    }
                } // sau khi add vô hết rồi thì return
                return list;
            }
        } finally {
            if (rs != null) {
                rs.close();
            }
            if (stm != null) {
                stm.close();
            }
            if (conn != null) {
                conn.close();
            }
        }
        return null; // nếu bị lỗi dòng nào đó thì nó sẽ xuống đâys
    }

    public ArrayList<PostDTO> getPostByTags(String tag)
            throws SQLException, ClassNotFoundException, NamingException {
        ArrayList<PostDTO> list = new ArrayList<>();
        Connection conn = null;
        PreparedStatement stm = null;
        ResultSet rs = null;
        try {
            conn = DBHelper.makeConnection();
            if (conn != null) {
                String sql = "SELECT title, tag, postid, emailpost, Day(ApprovedDate) AS ApprovedDay, "
                        + "month(ApprovedDate) AS ApprovedMonth, year(ApprovedDate) AS ApprovedYear, "
                        + "a.name, image, AwardID " + "FROM tblPosts p, tblAccounts a "
                        + "WHERE emailpost = email AND Tag like ? AND StatusPost = 'A'"
                        + "ORDER BY ApprovedDate desc"; // sắp xếp ngày gần đây nhất
                stm = conn.prepareStatement(sql);
                stm.setString(1, "%" + tag + "%");
                rs = stm.executeQuery();
                while (rs.next()) {
                    String postID = rs.getString("PostID");
                    String emailPost = rs.getString("EmailPost");
                    String approvedDate = rs.getString("ApprovedDay") + "-" + rs.getString("ApprovedMonth") + "-"
                            + rs.getString("ApprovedYear");
                    String tagFound = rs.getString("Tag");
                    String namePoster = rs.getString("Name");
                    String avatar = rs.getString("Image");
                    String titleColumn = rs.getString("Title");
                    int like = getLikeCounting(postID);
                    int awardID = rs.getInt("AwardID");
                    int comments = getCommentCounting(postID);
                    PostDTO p = new PostDTO(postID, emailPost, Style.convertTagToArrayList(tagFound), titleColumn,
                            approvedDate, namePoster, avatar, awardID, like, comments);
                    list.add(p);
                }
                return list;
            }
        } finally {
            if (rs != null) {
                rs.close();
            }
            if (stm != null) {
                stm.close();
            }
            if (conn != null) {
                conn.close();
            }
        }
        return null;
    }

    public PostDTO getPendingPostById(String id)
            throws SQLException, ClassNotFoundException, NamingException {
        Connection conn = null;
        PreparedStatement stm = null;
        ResultSet rs = null;
        try {
            conn = DBHelper.makeConnection();
            if (conn != null) {

                String sql = "SELECT title, tag, Day(p.createdDate) as createdDay, month(p.createdDate) as createdMonth, year(p.createdDate) as createdYear, PostContent, StatusPost, CategoryID, AwardID, "
                        + "name, image, email "
                        + "FROM tblPosts p left join tblAccounts a "
                        + "on Email = EmailPost Where postID = ?";

                stm = conn.prepareStatement(sql);
                stm.setString(1, id);
                rs = stm.executeQuery();
                if (rs.next()) {

                    String title = rs.getString("Title");
                    String createdAt = rs.getString("createdDay") + "-" + rs.getString("createdMonth") + "-"
                            + rs.getString("createdYear");
                    String tags = rs.getString("Tag");
                    String avatar = rs.getString("Image");
                    String name = rs.getString("Name");
                    
                    String content = rs.getString("PostContent");
                    String statusPost = rs.getString("StatusPost");
                    String email = rs.getString("Email");
                    String categoryID = rs.getString("CategoryID");
                    int awardID = rs.getInt("AwardID");
                    PostDTO post = new PostDTO(id, email, statusPost, createdAt, Style.convertTagToArrayList(tags), title, content, categoryID, name, avatar, awardID);
                    return post;
                }
            }
        } finally {
            if (rs != null) {
                rs.close();
            }
            if (stm != null) {
                stm.close();
            }
            if (conn != null) {
                conn.close();
            }
        }
        return null;
    }

    //Đây là phần paging của Ân đang cố làm (kememay)
    public ArrayList<PostDTO> pagingPosts(int index) throws SQLException, ClassNotFoundException, NamingException {
        Connection conn = null;
        PreparedStatement stm = null;
        ResultSet rs = null;
        ArrayList<PostDTO> list = new ArrayList<>();
        try {
            conn = DBHelper.makeConnection();
            if (conn != null) {
                String sql = "SELECT title, tag, postid, emailpost, Day(ApprovedDate) AS ApprovedDay, "
                        + "month(ApprovedDate) AS ApprovedMonth, year(ApprovedDate) AS ApprovedYear, "
                        + "name, image, AwardID FROM tblPosts p, tblAccounts a "
                        + "WHERE emailpost = email AND StatusPost = 'A'"
                        + "ORDER BY ApprovedDate desc OFFSET ? ROWS FETCH NEXT 10 ROWS ONLY";
                stm = conn.prepareStatement(sql);
                stm.setInt(1, (index - 1) * 10);
                rs = stm.executeQuery();
                while (rs.next()) {
                    String postID = rs.getString("PostID");
                    String emailPost = rs.getString("EmailPost");
                    String approvedDate = rs.getString("ApprovedDay") + "-" + rs.getString("ApprovedMonth") + "-"
                            + rs.getString("ApprovedYear");
                    String tag = rs.getString("Tag");
                    String title = rs.getString("Title");
                    String namePoster = rs.getString("Name");
                    String avatar = rs.getString("Image");
                    int like = getLikeCounting(postID);
                    int awardID = rs.getInt("AwardID");// bug 30%
                    int comments = getCommentCounting(postID);
                    PostDTO post = new PostDTO(postID, emailPost, Style.convertTagToArrayList(tag), title, approvedDate,
                            namePoster, avatar, awardID, like, comments);
                    list.add(post);
                }
            }
        } finally {
            if (rs != null) {
                rs.close();
            }
            if (stm != null) {
                stm.close();
            }
            if (conn != null) {
                conn.close();
            }
        }

        return list;
    }

    public int getTotalPost() throws SQLException, ClassNotFoundException, NamingException {
        Connection conn = null;
        PreparedStatement stm = null;
        ResultSet rs = null;
        try {
            conn = DBHelper.makeConnection();
            if (conn != null) {
                String sql = "select count(PostID) as Total from tblPosts where StatusPost = 'A'";
                stm = conn.prepareStatement(sql);
                rs = stm.executeQuery();
                if (rs.next()) {
                    return rs.getInt("Total");
                }
            }
        } finally {
            if (rs != null) {
                rs.close();
            }
            if (stm != null) {
                stm.close();
            }
            if (conn != null) {
                conn.close();
            }
        }
        return 0;
    }

    public boolean setNewStatusPost(String postID, String emailMentor, String newStatus) throws NamingException, SQLException {
        Connection conn = null;
        PreparedStatement stm = null;
        ResultSet rs = null;
        boolean check = false;
        try {
            conn = DBHelper.makeConnection();
            if (conn != null) {
                String sql = "update tblposts set statuspost = ?, emailapprover = ?, ApprovedDate = getdate()"
                        + " where postid = ?";
                stm = conn.prepareStatement(sql);
                stm.setString(1, newStatus);
                stm.setString(2, emailMentor);
                stm.setString(3, postID);

                check = stm.executeUpdate() > 0;
            }
        } finally {
            if (rs != null) {
                rs.close();
            }
            if (stm != null) {
                stm.close();
            }
            if (conn != null) {
                conn.close();
            }
        }
        return check;
    }
    
    public boolean deletePost(String postId) throws NamingException, SQLException{
        Connection conn = null;
        PreparedStatement stm = null;
        ResultSet rs = null;
        boolean check = false;
        try{
            conn =DBHelper.makeConnection();
            if(conn != null){
                String sql = "update tblPosts set statuspost = 'WFD' where postid = ? ";
                stm = conn.prepareStatement(sql);
                stm.setString(1,postId);
                
                check = stm.executeUpdate() > 0;
            }
        }finally{
            if (rs != null) {
                rs.close();
            }
            if (stm != null) {
                stm.close();
            }
            if (conn != null) {
                conn.close();
            }
        }
        return check;
    }
    
    public boolean checkOwnerPost(String email, String postId) throws NamingException, SQLException{
        Connection conn = null;
        PreparedStatement stm = null;
        ResultSet rs = null;
        boolean check = false;
        try{
            conn =DBHelper.makeConnection();
            if(conn != null){
                String sql = "select PostId from tblPosts where PostID = ? and EmailPost = ? ";
                stm = conn.prepareStatement(sql);
                stm.setString(1, postId);
                stm.setString(2, email);
                rs = stm.executeQuery();
                if(rs.next()){
                    check = true;
                }
            }
        }finally{
            if (rs != null) {
                rs.close();
            }
            if (stm != null) {
                stm.close();
            }
            if (conn != null) {
                conn.close();
            }
        }
        return check;
    }
}
