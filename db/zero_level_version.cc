#include "zero_level_version.h"
#include "version_control.h"
#include "leveldb/index.h"

namespace leveldb {

enum SaverState {
  kNotFound,
  kFound,
  kDeleted,
  kCorrupt,
};

struct Saver {
  SaverState state;
  const Comparator* ucmp;
  Slice user_key;
  std::string* value;
};

static void SaveValue(void* arg, const Slice& ikey, const Slice& v) {
  Saver* s = reinterpret_cast<Saver*>(arg);
  ParsedInternalKey parsed_key;
  if (!ParseInternalKey(ikey, &parsed_key)) {
    s->state = kCorrupt;
  } else {
    if (s->ucmp->Compare(parsed_key.user_key, s->user_key) == 0) {
      s->state = (parsed_key.type == kTypeValue) ? kFound : kDeleted;
      if (s->state == kFound) {
        s->value->assign(v.data(), v.size());
      }
    }
  }
}

Status ZeroLevelVersion::Get(const ReadOptions& options, const LookupKey& key, std::string* val) {
  Status s;
  Slice ikey = key.internal_key();
  Slice user_key = key.user_key();
  const Comparator* ucmp = vcontrol_->user_comparator();

  Index* index = vcontrol_->options()->index;
  IndexMeta index_meta = index->Get(user_key);
  if (convert(index_meta) != 0) {

    Saver saver;
    saver.state = kNotFound;
    saver.ucmp = ucmp;
    saver.user_key = user_key;
    saver.value = val;
//    uint64_t fsize = GetFileSize(index_meta.file_number);
    s = vcontrol_->cache()->Get(options, index_meta.file_number, index_meta.offset, index_meta.size,
                                ikey, &saver, SaveValue);
    if (!s.ok()) {
      return s;
    }
    switch (saver.state) {
      case kNotFound:
        s = Status::NotFound(Slice());
        return s;
      case kFound:
        return s;
      case kDeleted:
        s = Status::NotFound(Slice());
        return s;
      case kCorrupt:
        s = Status::Corruption("corrupted key for", user_key);
        return s;
    }
  }
  return Status::NotFound(Slice());
}

void ZeroLevelVersion::Ref() {
  ++refs_;
}

void ZeroLevelVersion::Unref() {
//  assert(this != vcontrol_->next_version());
  assert(refs_ >= 1);
  --refs_;
  if (refs_ == 0) {
    delete this;
  }
}

std::string ZeroLevelVersion::DebugString() const {
  std::string r;
  r.append("Files:\n");
  for (const auto& file : files_) {
    r.push_back(' ');
    AppendNumberTo(&r, file.second->number);
    r.push_back(':');
    AppendNumberTo(&r, file.second->file_size);
    r.append("[");
    r.append(file.second->smallest.DebugString());
    r.append(" .. ");
    r.append(file.second->largest.DebugString());
    r.append("]");
    r.append(" {");
    AppendNumberTo(&r, file.second->alive);
    r.append(" / ");
    AppendNumberTo(&r, file.second->total);
    r.append("}\n");
  }
  r.append("Files to merge:\n");
  for (const auto& file : merge_candidates_) {
    r.push_back(' ');
    AppendNumberTo(&r, file.second->number);
    r.push_back(':');
    AppendNumberTo(&r, file.second->file_size);
    r.append("[");
    r.append(file.second->smallest.DebugString());
    r.append(" .. ");
    r.append(file.second->largest.DebugString());
    r.append("]");
    r.append(" {");
    AppendNumberTo(&r, file.second->alive);
    r.append(" / ");
    AppendNumberTo(&r, file.second->total);
    r.append("}\n");
  }
  return r;
}

void ZeroLevelVersion::AddFile(std::shared_ptr<FileMetaData> f) {
  files_.insert({f->number, f});
}

void ZeroLevelVersion::AddCompactionFile(std::shared_ptr<FileMetaData> f) {
  merge_candidates_.insert({f->number, f});
}

} // namespace leveldb
