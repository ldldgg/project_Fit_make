package com.fm.item.dao;

import java.util.List;
import java.util.Map;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.fm.item.model.ItemDto;

@Repository
public class ItemDaompl implements ItemDao{
	
	@Autowired
	SqlSessionTemplate sqlSession;
	
	String namespace = "com.fm.item.";
//	C
	@Override
	public int itemInsertOne(ItemDto itemDto) {
		return sqlSession.insert(namespace + "itemInsertOne", itemDto);
	}
//	R
	@Override
	public List<ItemDto> itemSelectList(){
		return sqlSession.selectList(namespace + "itemSelectList");
	}
	
	@Override
	public ItemDto itemSelectOne(int no) {
		return sqlSession.selectOne(namespace + "itemSelectOne", no);
	}
	
//	U
	@Override
	public int itemUpdateOne(ItemDto itemDto) {
		return sqlSession.selectOne(namespace + "itemUpdateOne", itemDto);
	}
	
	@Override
	public void itemDeleteOne(int no){
		sqlSession.delete(namespace + "itemDeleteOne", no);
	
	}
	
	//----------------------------------------------------------
	
	@Override
	public void insertFile(Map<String, Object> map) {
		
		sqlSession.insert(namespace + "insertFile", map);
	}
}
