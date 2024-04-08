-----
### Command Pattern 
-----
1. MVC Pattern에서 Controller Servlet은 사용자가 어떤 기능을 요청했는지 분석
2. 사용자가 어떤 기능을 요구했는지 판단하기 위해 사용하는 방법 중 가장 일반적인 방법
   - 예를 들어, '게시판글목록보기', '게시판글쓰기' 명령 들을 Controller Servlet에 전송하여, 이 전송한 명령어에 해당하는 기능을 수행한 후 View를 통해 결과를 보여주는 방식

3. 웹 브라우저를 통해 명령어를 전달하는 방법 : 특정 이름의 파라미터에 명령어 정보 전달 / 요청 URL 자체를 명령어로 사용
4. 예시
```java
String command = request.getParameter("cmd");

String viewPage = null;

if(command == null) {
  // 명령어 오류 처리
  viewPage = "error/invaildCommand.jsp";
} else if (command.equals("BoardList")) {
  // 글 목록 읽기 요청 처리
  ...
  viewPage = "/board/list.jsp";
} else if(command.equals("BoardWriteForm")) {
  // 글 쓰기 입력 등 요청 처리
  ...
  viewPage = "/board/writeForm.jsp";
}

  RequestDisspatcher rd = request.getRequestDispatcher(viewPage);
  rd.forward(request, response);
```

-----
### Command Pattern을 이용한 명령어 처리기의 분리
-----
1. Command Pattern : 명령어에 해당하는 로직 처리 코드를 별도 클래스에 작성
2. 하나의 명령어를 하나의 클래스에서 처리하도록 구현하는 패턴
3. 위의 코드를 다음과 같이 변경
```java
String command = request.getParameter("cmd");
CommandHandler handler = null;

if(command == null) {
  // 명령어 오류 처리
  handler = new NullHandler();
} else if (command.equals("BoardList")) {
  // 글 목록 읽기 요청 처리
  ...
  handler = new BoardListHandler();
} else if(command.equals("BoardWriteForm")) {
  // 글 쓰기 입력 등 요청 처리
  ...
  handler = new BoardWriteFormHandler();
}

String viewPage = handler.service(request, response);

  RequestDisspatcher rd = request.getRequestDispatcher(viewPage);
  rd.forward(request, response);
```

-----
### CommandHandler의 구현
-----
<div align="center">
<img src="https://github.com/sooyounghan/Web/assets/34672301/eb7f7fda-54f5-42bd-9fb4-cf0109aefffc">
</div>

1. CommandHandler를 인터페이스로 구현
2. NullHandler, BoardListHandler 등의 클래스는 각 명령어에 해당하는 로직 실행 코드를 담고 있는 클래스
3. 로직을 수행하기 위해 service() 메서드를 호출하고 결과를 보여줄 뷰 페이지의 정보를 return
4. 즉, Controller Servlet은 명령어에 해당하는 CommandHandler 인스턴스를 생성하고, 실제 로직 처리는 생성한 CommanHandler 인스턴스에서 실행되는 구조

<div align="center">
<img src="https://github.com/sooyounghan/Web/assets/34672301/83303341-dffb-40f3-b87d-9ee1af547462">
</div>

5. 즉, CommandHandler Interface의 구조는 다음과 같이 설정 가능
```java
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

public interface CommandHandler {
  public String service(HttpServletRequest request, HttpServletResponse response) throws Excpetion;
}
```
  - 즉, 모든 CommandHandler Class가 공통으로 구현해야 할 메서드를 선언
  - CommandHandler Class는 service() 메서드를 이용해 알맞은 Logic 코드를 구현하고 결과를 보여줄 JSP View Page를 Return

```java
public class SomeHandler implements CommandHandler {
  public String service(HttpServletRequest request, HttpServletResponse response) {
     // 1. 명령어와 관련된 비즈니스 로직 처리
   
     // 2. View Page에서 사용할 정보 저장
     request.setAttribute("someValue", someValue);
   
     // 3. View Page URL Return
     return "/view/Someview.jsp";
   }
}
```

-----
### Properties를 이용한 Command와 CommandClass 관계 명시
-----
1. <Command, Handler Class>의 Mapping 정보를 Properties 파일에 저장
2. 예시
```java
BoardList=myjsp.command.BoardListHandler
BoardWriteForm=myjsp.command.BoardWriteFormHandler
...
```
3. 즉, Command=HandlerClass의형태로 구성
4. Controller Servlet은 init() 메서드를 통해 Servlet을 생성하고 초기화할 때, 설정 파일을 이용해 Handler 객체를 미리 생성해두었다가 service() 메서드에서 사용
```java
package mvc.controller;

import java.io.*;
import java.util.*;
import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import mvc.command.CommandHandler;
import mvc.command.NullHandler;

public class SimpleController extends HttpServlet {
    // Map<Command, HandlerClass> Mapping 정보 저장
    private Map<String, CommandHandler> commandHandlerMap = new HashMap<>();

    public void init() throws ServletException {
        String configFile = getInitParameter("configFile");
        Properties prop = new Properties();
        String configFilePath = getServletContext().getRealPath(configFile);
  
        try(FileInputStream fis = new FileReader(configFilePath) {
          prop.load(fis);
        } catch(IOException e) {
          throw new ServletException();
        }
  
        Iterator it = prop.keySet().iterator();
  
        while(it.hasNext()) {
  
          String command = (String)it.next();
          String handlerClassName = prop.getProperty(command);
  
          try {
            Class<?> handlerClass = Class.forName(handlerClassName);
            CommandHandler handlerInstance = (CommandHandler) handlerClass.newInstance();
            commandHandlerMap.put(command, handlerInstance);
          } catch(ClassNotFoundException | InstaniatonException | IllegalAccessedException e) {
            throw new ServletException();
          }
      }
  }


    protected void doGet(HttpServletRequest request, HttpServletResponse responses) throws ServletException, IOException {
        service(request, response);
  	}
    
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
  		  service(request, response);
  	}

    protected void service(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        Stirng command = request.getParameter("command");

        CommandHandler handler = commandHandlerMap.get(command);

        if(handler == null) {
          handler = new NullHandler();
        }

        String viewPage = null;

        try {
          viewPage = handler.service(reqeust, response);
        } catch(Exception e) {
          throw new ServletException();
        }

        if(viewPage != null) {
          RequestDispatcher dispatcher = req.getRequestDispatcher(viewPage);
          dispatcher.forward(req, res);
        }
    }
}
```

-----
### web.xml를 이용한 configFile 초기화 파라미터 설정 파일 경로 설정
-----
```jsp
<servlet>
  <servlet-name>ControllerusingFile</servlet-name>
  <servlet-class>mvc.controller.ControllerUsingFile</servlet-class>
  <init-param>
    <param-name>configFile</param-name>
    <param-value>WEB-INF/commandHandler.properties</param-value>
  </init-param>
  <load-up-start>1</load-up-start>
</servlet>

<servlet-mapping>
  <servlet-name>ControllerusingFile</servlet-name>
  <url-pattern>/controllerUsingFile</url-pattern>
</servlet-mapping>
```

-----
### NullHandler의 구현
-----
```java
package mvc.command;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

public class NullHandler implements CommandHandler {
    @Override
    public String service(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        response.sendError(HttpServletResponse.SC_NOT_FOUND);
        return null;
    }
}
```


-----
### 요청 URL를 명령어로 사용
-----
1. URL를 사용하면 파라미터로 명령어를 전달할 때, 발생하는 사용자의 악의적인 잘못된 명령어 입력을 일차적 에방 가능
2. 예시
```java
String command = request.getRequestURI();

if(command.indexOf(request.getContextPath() == 0) {
  command = command.subString(reqeust.getContextpath().length());
}
```

3. 이처럼 위의 CommandHandler Class의 service() 코드에 적용하면,
```java
    protected void service(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        Stirng command = request.getRequestURI();

        if(command.indexOf(reqeust.getContextPath()) == 0) {
            command = command.subString(request.getContextPath().length());
        }

        CommandHandler handler = commandHandlerMap.get(command);

        if(handler == null) {
          handler = new NullHandler();
        }

        String viewPage = null;

        try {
          viewPage = handler.service(reqeust, response);
        } catch(Exception e) {
          throw new ServletException();
        }

        if(viewPage != null) {
          RequestDispatcher dispatcher = req.getRequestDispatcher(viewPage);
          dispatcher.forward(reqeust, response);
        }
    }
```
```jsp
<servlet>
  <servlet-name>ControllerusingURI</servlet-name>
  <servlet-class>mvc.controller.ControllerUsingFile</servlet-class>
  <init-param>
    <param-name>configFile</param-name>
    <param-value>WEB-INF/commandHandler.properties</param-value>
  </init-param>
  <load-up-start>1</load-up-start>
</servlet>

<servlet-mapping>
  <servlet-name>ControllerusingURI</servlet-name>
  <url-pattern>*.do</url-pattern>
</servlet-mapping>
```
: *.do로 오는 요청은 ControllerUsingURI ControllerServlet으로 전달
