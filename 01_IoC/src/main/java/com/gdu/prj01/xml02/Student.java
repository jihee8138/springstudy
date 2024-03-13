package com.gdu.prj01.xml02;

import java.util.List;
import java.util.Map;
import java.util.Set;

import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@NoArgsConstructor

public class Student {
  
  private List<Integer> scores;
  private Set<String> contacts;
  private Map<String, String> friends;

}
