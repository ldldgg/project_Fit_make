package com.fm.item.dao;

import java.util.List;
import java.util.Map;

import com.fm.item.model.ItemDto;

public interface ItemDao {
	public int itemInsertOne(ItemDto itemDto);

	public List<ItemDto> itemSelectList(int cNo, String keyword, int start, int end, int older);
	
	public ItemDto itemSelectOne(int no);

	int itemUpdateOne(ItemDto itemDto);

	public void itemDeleteOne(int no);

//-----------------------------------------------------------
	
	public void insertFile(Map<String, Object> map);

	public List<Map<String, Object>> fileSelectList(int no);
	
	public Map<String, Object> fileSelectOne(int no);

//-----------------------------------------------------------
	
	public int fileDelete(int no);

	public int itemSelectTotalItemCount(int cNo, String keyword);
}
