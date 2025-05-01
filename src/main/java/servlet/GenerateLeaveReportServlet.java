package servlet;

import com.itextpdf.text.Document;
import com.itextpdf.text.DocumentException;
import com.itextpdf.text.Paragraph;
import com.itextpdf.text.pdf.PdfWriter;
import com.itextpdf.text.pdf.PdfPTable;
import com.itextpdf.text.Font;
import com.itextpdf.text.Element;


import jakarta.servlet.*;
import jakarta.servlet.http.*;
import java.io.*;
import java.sql.*;
import java.text.SimpleDateFormat;

public class GenerateLeaveReportServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
    	HttpSession session = request.getSession(false);
    	if (session == null || session.getAttribute("username") == null) {
    	    response.sendRedirect("login.jsp");
    	    return;
    	}

    	
    	// Get the status filter from the request, default is "all"
        String statusFilter = request.getParameter("status");
        if (statusFilter == null) statusFilter = "all";

        // Prepare PDF document
        Document document = new Document();
        ByteArrayOutputStream outputStream = new ByteArrayOutputStream();

        try {
            // Set up PDF writer
            PdfWriter.getInstance(document, outputStream);

            // Open the document
            document.open();
            
            // Add title
            Font titleFont = new Font(Font.FontFamily.HELVETICA, 18, Font.BOLD);
            Paragraph title = new Paragraph("Leave Report", titleFont);
            title.setAlignment(Element.ALIGN_CENTER);
            document.add(title);
            document.add(new Paragraph("\n"));

            // Set up database connection
            Connection conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/leave_management", "root", "root");
            PreparedStatement stmt;
            ResultSet rs;

            // Prepare the query based on filter
            String query;
            if ("all".equals(statusFilter)) {
                query = "SELECT username, leave_type, submission_date, start_date, end_date, status FROM leave_applications";
                stmt = conn.prepareStatement(query);
            } else {
                query = "SELECT username, leave_type, submission_date, start_date, end_date, status FROM leave_applications WHERE status = ?";
                stmt = conn.prepareStatement(query);
                stmt.setString(1, statusFilter);
            }

            rs = stmt.executeQuery();
            SimpleDateFormat sdf = new SimpleDateFormat("dd-MM-yyyy");

            // Create table header
            PdfPTable table = new PdfPTable(6);
            table.setWidthPercentage(100);
            table.addCell("Username");
            table.addCell("Leave Type");
            table.addCell("Submission Date");
            table.addCell("Start Date");
            table.addCell("End Date");
            table.addCell("Status");

            // Add data rows
            while (rs.next()) {
                table.addCell(rs.getString("username"));
                table.addCell(rs.getString("leave_type"));
                table.addCell(sdf.format(rs.getDate("submission_date")));
                table.addCell(sdf.format(rs.getDate("start_date")));
                table.addCell(sdf.format(rs.getDate("end_date")));
                table.addCell(rs.getString("status").toUpperCase());
            }

            document.add(table);

            // Close the document
            document.close();

            // Set response type as PDF
            response.setContentType("application/pdf");
            response.setHeader("Content-Disposition", "attachment;filename=Leave_Report.pdf");

            // Write the PDF content to the response output stream
            response.getOutputStream().write(outputStream.toByteArray());
            response.getOutputStream().flush();
            response.getOutputStream().close();

        } catch (Exception e) {
            e.printStackTrace();
            response.getWriter().write("Error generating PDF: " + e.getMessage());
        }
    }
}
