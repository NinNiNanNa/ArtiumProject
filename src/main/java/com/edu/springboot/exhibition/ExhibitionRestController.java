package com.edu.springboot.exhibition;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RestController;

@RestController
public class ExhibitionRestController {
   
   @Autowired
   IExhibitionRestService dao;
   
   @GetMapping("/exhibitionReviewList.api")
   public List<SimpleReviewDTO> restReviewList(ParameterDTO parameterDTO){
      int pageSize = 10;
      int pageNum = parameterDTO.getPageNum()==null ? 1 : Integer.parseInt(parameterDTO.getPageNum());
      int start = (pageNum - 1) * pageSize + 1;
      int end = pageNum * pageSize;
      parameterDTO.setStart(start);
      parameterDTO.setEnd(end);
      List<SimpleReviewDTO> reviewList = dao.listSimpleReview(parameterDTO);
      return reviewList;
   }
   
   @GetMapping("/exhibitionReviewView.api")
   public SimpleReviewDTO resetSimpleReviewView(ParameterDTO parameterDTO) {
      SimpleReviewDTO simpleReviewDTO = dao.viewSimpleReview(parameterDTO);
      return simpleReviewDTO;
   }
   
   @PostMapping("/exhibitionReviewWrite.api")
   public Map<String, Integer> restSimpleReviewWrite(SimpleReviewDTO simpleReviewDTO){
      int result = dao.writeSimpleReview(simpleReviewDTO);
      Map<String, Integer> map = new HashMap<>();
      map.put("result", result);
      return map;
   }

}