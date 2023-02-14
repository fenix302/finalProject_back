package work.comm;

import java.io.File;
import java.io.IOException;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;
import org.springframework.web.servlet.ModelAndView;

import work.user.UserService;

@Controller
public class CommController {
	@Resource(name = "commService")
	private CommService commService;

	@Resource(name = "userService")
	private UserService userService;


	@RequestMapping(value="/work/comm/createBoard.do", method = {RequestMethod.GET, RequestMethod.POST})
	public ModelAndView createBoard(@ModelAttribute CommBean board, HttpServletRequest request){
		
		HttpSession session = request.getSession();
		
//		String writer = (String)session.getAttribute("writer");

		ModelAndView mv = new ModelAndView();

		String flag = board.getTitle(); //BoardBean 존재여부

		if(flag == null){
			mv.setViewName("/comm/boardRegisterC");
		}else if(flag != null){
			//게시글 생성
//			board.setWriter(writer);
			commService.createBoard(board);

			String maxBoardNo = commService.retrieveMaxBoardNo();

			mv.setViewName("redirect:/work/comm/retrieveBoardList.do?maxBoardNo=" + maxBoardNo);
		}

		return mv;
		
	}
	
	
	@RequestMapping(value="/work/comm/goMain.do", method = {RequestMethod.GET, RequestMethod.POST})
	public String goMain(){
//		ModelAndView mv = new ModelAndView();
//
//		mv.setViewName("/intro/index");

		return "redirect:/intro/index.jsp";
	}

	@RequestMapping(value="/work/comm/retrieveBoard.do", method = {RequestMethod.GET, RequestMethod.POST})
	public ModelAndView retrieveBoard(HttpServletRequest request){
		ModelAndView mv = new ModelAndView();

		String boardNo = request.getParameter("bno");

//		if(boardNo == null) boardNo = request.getParameter("boardNo");

		Map<String, String> boardParam = new HashMap<String, String>();

		boardParam.put("BNO", boardNo);

		Map<String, String> dsBoard = commService.retrieveBoard(boardParam);


		mv.addObject("dsBoard", dsBoard);

		mv.setViewName("/comm/boardR");

		return mv;
	}

	@RequestMapping(value="/work/comm/retrieveBoardList.do", method = {RequestMethod.GET, RequestMethod.POST})
	public ModelAndView retrieveBoardList(HttpServletRequest request){
		ModelAndView mv = new ModelAndView();

		Map<String, String> boardParam = new HashMap<String, String>();

		List<Map<String, String>> dsBoardList = commService.retrieveBoardList(boardParam);

		mv.addObject("dsBoardList", dsBoardList);
		mv.setViewName("/comm/boardListR");

		return mv;
	}

	@RequestMapping(value="/work/comm/deleteBoard.do", method= {RequestMethod.GET, RequestMethod.POST})
	public ModelAndView deleteBoard(HttpServletRequest request){
		ModelAndView mv = new ModelAndView();

		Map<String, String> boardParam = new HashMap<String, String>();
//		Map<String, String> replyParam = new HashMap<String, String>();
//		Map<String, String> markParam = new HashMap<String, String>();

		HttpSession session = request.getSession();

//		String userCode = (String)session.getAttribute("userCode");
		String boardNo = request.getParameter("bno");

//		boardParam.put("userCode", userCode);
		boardParam.put("BNO", boardNo);

//		replyParam.put("BNO", boardNo);

//		markParam.put("BNO", boardNo);

		//글 삭제
		commService.deleteBoard(boardParam);

		mv.setViewName("redirect:/work/comm/retrieveBoardList.do");

		return mv;
	}

	@RequestMapping(value="/work/comm/updateBoardRating.do", method=RequestMethod.GET)
	public ModelAndView updateBoardRating(HttpServletRequest request){
		ModelAndView mv = new ModelAndView();

		HttpSession session = request.getSession();

		Map<String, String> boardParam = new HashMap<String, String>();
		Map<String, String> markParam = new HashMap<String, String>();

		String userCode = (String)session.getAttribute("userCode");
		String boardNo = request.getParameter("boardNo");

		boardParam.put("boardNo", boardNo);

		markParam.put("userCode", userCode);
		markParam.put("boardNo", boardNo);

		mv.setViewName("redirect:/work/comm/retrieveBoard.do?boardNo=" + boardNo + "&fromRating=true");

		return mv;
	}

	@RequestMapping(value="/work/comm/updateBoard.do", method = {RequestMethod.GET, RequestMethod.POST})
	public ModelAndView updateBoard1(HttpServletRequest request, @ModelAttribute CommBean board){
		Map<String, String> boardParam = new HashMap<String, String>();
		ModelAndView mv = new ModelAndView();
        String boardNo = request.getParameter("bno"); //없으면 GET(create안함), 있으면 POST(create)

        String flag = board.getTitle();
        boardParam.put("BNO", boardNo);

        Map<String, String> dsBoard = commService.retrieveBoard(boardParam);

		if(flag == null){
			mv.addObject("dsBoard", dsBoard);
			mv.setViewName("/comm/boardRegisterU");
		}else{
			commService.updateBoard(board);
			mv.setViewName("/work/comm/retrieveBoard.do?boardNo=" + boardNo);
		}
		return mv;
	}

}