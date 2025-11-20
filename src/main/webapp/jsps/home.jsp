<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.net.*" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>MithunTechnologies - Home Page</title>
<link href="images/mithunlogo.jpg" rel="icon">
</head>

<body>

<!-- ===================== GREEN VERSION INDICATOR ===================== -->
<h1 align="center" style="color:green; font-size:48px;">
    GREEN VERSION ACTIVE
</h1>
<!-- ================================================================== -->

<h1 align="center">Hareesh Learning</h1>
<h1 align="center">
    I have gained strong hands-on experience in AWS, DevOps, Jenkins, Docker, Kubernetes,
    GitOps, ArgoCD, Terraform, and related cloud technologies through practical, real-time project work.
</h1>

<h1 align="center">Harsh516</h1>

<hr><br>

<h1>
    <h3>Server Side IP Address</h3>

    <%
    String ip = "";
    InetAddress inetAddress = InetAddress.getLocalHost();
    ip = inetAddress.getHostAddress();
    out.println("Server Host Name :: " + inetAddress.getHostName());
    %>
    <br>
    <%
    out.println("Server IP Address :: " + ip);
    %>
</h1>

<br>

<h1>
    <h3>Client Side IP Address</h3>
    <% out.print("Client IP Address :: " + request.getRemoteAddr()); %><br>
    <% out.print("Client Name Host :: " + request.getRemoteHost()); %><br>
</h1>

<hr>

<div style="text-align: center;">
    <span style="font-weight: bold;">
        **************************************************
    </span>
</div>

<hr><hr>

<p align="center">Harsh516 Center.</p>

</body>
</html>
