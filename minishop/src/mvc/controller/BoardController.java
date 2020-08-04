package mvc.controller;

import java.io.IOException;
import java.util.ArrayList;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import mvc.model.board.BoardDAO;
import mvc.model.board.BoardDTO;

public class BoardController extends HttpServlet {

	private static final long serialVersionUID = 1L;
	//한페이지당 보여지는 자료수
	static final int LISTCOUNT = 10;
	
	@Override
	protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		doPost(req,resp);
	}
	@Override
	protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {

		String RequestURI = req.getRequestURI();
		String contextPath = req.getContextPath();
		String command = RequestURI.substring(contextPath.length());
		
		resp.setContentType("text/html; charset=utf-8");
		//서블릿 호출 명령
		//게시판 내역 보기
		if (command.equals("/BoardListAction.do")) {//등록된 글 목록 출력하기
			requestBoardList(req);
			RequestDispatcher rd = req.getRequestDispatcher("./board/list.jsp");
			rd.forward(req, resp);
		}else if(command.equals("/BoardWriteForm.do")) {
		 //게시판등록페이지 출력
			requestLoginName(req);
			RequestDispatcher rd = req.getRequestDispatcher("./board/writeForm.jsp");
			rd.forward(req, resp);
		}else if(command.equals("/BoardWriteAction.do")) {
		 //게시판 신규등록
			requestBoardWrite(req);
			RequestDispatcher rd = req.getRequestDispatcher("/BoardListAction.do");
			rd.forward(req, resp);
		}else if(command.equals("/BoardViewAction.do")) {
		 //게시판 상세보기
			requestBoardView(req);
			RequestDispatcher rd = req.getRequestDispatcher("/BoardView.do");
			rd.forward(req, resp);
		}else if(command.equals("/BoardView.do")) {
		 //게시판 상세보기 출력
			RequestDispatcher rd = req.getRequestDispatcher("./board/view.jsp");
			rd.forward(req, resp);
		}else if(command.equals("/BoardUpdateAction.do")) {
		 //게시판 수정& 조회수 +1
			requestBoardUpdate(req);
			RequestDispatcher rd = req.getRequestDispatcher("/BoardListAction.do");
			rd.forward(req, resp);
		}else if(command.equals("/BoardDeleteAction.do")) {
		 //게시판 삭제
			requestBoardDelete(req);
			RequestDispatcher rd = req.getRequestDispatcher("/BoardListAction.do");
			rd.forward(req, resp);
		}
	}
	//등록된 게시판 정보 가져오기
	public void requestBoardList(HttpServletRequest req) {
		
		//getInstance() : 싱글톤 패턴
		//한번만 메모리에 인스턴스를 생성하고 공유처리
		BoardDAO dao = BoardDAO.getInstance();
		//게시물 대입을 위해 선언
		ArrayList<BoardDTO> boardlist = new ArrayList<BoardDTO>();
		
		int pageNum = 1;
		int limit = LISTCOUNT;//한페이지당 자료 갯수 
		
		if(req.getParameter("pageNum") != null) {
			pageNum = Integer.parseInt(req.getParameter("pageNum"));
		}	
		//검색조건(제목,내용,작성자)
		String items = req.getParameter("items");
		//검색어 문자열
		String text = req.getParameter("text");
		//검색 총건수
		int total_record = dao.getListCount(items, text);
		
		//테이블에서 자료를 가져와서 arraylist에 대입
		boardlist = dao.getBoardList(pageNum, limit, items, text);
		
		int total_page;//자료를 보여줄 총페이지수
		
	
		//Math.ceil 은 소수값이 존재할 때 값을 올리는 역활을 하는 함수이며,
        //Math.floor 는 소수값이 존재할 때 소수값을 버리는 역활을 하는 함수이며,
        //Math.round 는 소수값에 따라 올리거나 버리는 역활을 하는 반올림 함수입니다.
		if (total_record % limit == 0){     
	     	total_page =total_record/limit;
	     	Math.floor(total_page);  
		}
		else{
		   //한페이지를 못채우는 자료 출력을 위해 +1	
		   total_page =total_record/limit;
		   Math.floor(total_page); 
		   total_page =  total_page + 1; 
		}	
		
   		req.setAttribute("pageNum", pageNum);//현재페이지수		  
   		req.setAttribute("total_page", total_page);//총페이지수   
		req.setAttribute("total_record",total_record);//총데이터건수 
		req.setAttribute("boardlist", boardlist);
	}
	
	//로그인 id의 이름을 가져오기
	public void requestLoginName(HttpServletRequest req) {

		String id = req.getParameter("id");
		BoardDAO dao = BoardDAO.getInstance();
		String name = dao.getLoginNameById(id);
		
		req.setAttribute("name",name);
		
	}
	
	//게시판 등록 처리
	public void requestBoardWrite(HttpServletRequest req) {
		
		BoardDAO dao = BoardDAO.getInstance();
		//게시판 인스턴스 생성
		BoardDTO board = new BoardDTO();
		
		//board 객체에 값 대입
		board.setId(req.getParameter("id"));
		board.setName(req.getParameter("name"));
		board.setSubject(req.getParameter("subject"));
		board.setContent(req.getParameter("content"));
		
		//게시판 등록일시
		java.text.SimpleDateFormat formatter = 	new java.text.SimpleDateFormat("yyyy/MM/dd(HH:mm:ss)");	
		
		String regist_day = formatter.format(new java.util.Date());
		
		board.setRegday(regist_day);
		board.setHit(0);//신규 등록일 경우 조회수 0
		board.setIp(req.getRemoteAddr());//ip
		
		//boardDAO에 있는 게시판 등록 처리
		dao.insertBoard(board);
	}
	
	//특정 게시물에 대한 정보를 가져오기
	public void requestBoardView(HttpServletRequest req) {
		
		BoardDAO dao = BoardDAO.getInstance();
		int num = Integer.parseInt(req.getParameter("num"));
		int pageNum = Integer.parseInt(req.getParameter("pageNum"));
		
		BoardDTO board = new BoardDTO();
		
		//특정 게시판 번호와 현재 페이지에 해당하는
		//게시물 가져오기
		board = dao.getBoardByNum(num,pageNum);
		
		req.setAttribute("num",num);
		req.setAttribute("page",pageNum);
		req.setAttribute("board",board);
	}
	
	public void requestBoardUpdate(HttpServletRequest req) {
		int num = Integer.parseInt(req.getParameter("num"));
		int pageNum = Integer.parseInt(req.getParameter("pageNum"));
		
        BoardDAO dao = BoardDAO.getInstance();
        
        BoardDTO board = new BoardDTO();
        
        board.setNum(num);//게시물번호
        board.setName(req.getParameter("name"));//작성자
        board.setSubject(req.getParameter("subject"));//제목
        board.setContent(req.getParameter("content"));//내용
        
		java.text.SimpleDateFormat formatter =
				new java.text.SimpleDateFormat("yyyy/MM/dd(HH:mm:ss)");

		String regist_day = 
			formatter.format(new java.util.Date());
		
		board.setRegday(regist_day);
		board.setHit(0);
		board.setIp(req.getRemoteAddr());
		
		dao.updateBoard(board);
	}
	
	//특정 게시물 삭제처리
	public void requestBoardDelete(HttpServletRequest req) {
		int num = Integer.parseInt(req.getParameter("num"));
		
		BoardDAO dao = BoardDAO.getInstance();
		
		dao.deleteBoard(num);
	}
}
